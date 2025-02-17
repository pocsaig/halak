import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Link, useParams } from 'react-router-dom';
import axios from 'axios';
import './App.css';

const fetchData = async (url) => {
  try {
    const response = await axios.get(url);
    return response.data;
  } catch (error) {
    console.error('API hiba:', error);
    return { error: 'Nem sikerült betölteni az adatokat.' };
  }
};

const HalakEsTavuk = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    const loadData = async () => {
      const result = await fetchData('https://localhost:7113/halak');
      setData(result);
    };
    loadData();
  }, []);

  return (
    <div className="content">
      <h2>Halak és Tavuk</h2>
      {data ? (
        <div>
          {data.map((item, index) => (
            <div key={index}>
              <p><strong>Név:</strong> {item.nev}</p>
              <p><strong>Tó:</strong> {item.tonev}</p>
              {/* Add more fields if needed */}
              <hr />
            </div>
          ))}
        </div>
      ) : (
        <p>Betöltés...</p>
      )}
    </div>
  );
};

const HalByHorgasz = () => {
  const [nev, setNev] = useState('');
  const [data, setData] = useState(null);

  const handleInputChange = (e) => {
    setNev(e.target.value);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (nev) {
      setData(null); // Clear previous data before fetching new data
      try {
        const result = await fetchData(`https://localhost:7113/horgasz/${nev}`);
        console.log(result); // Kiírjuk a választ, hogy lássuk mi érkezik
        if (result.length > 0) {
          setData(result[0]); // Ha van adat, az első elemet beállítjuk
        } else {
          setData({ error: 'Nincs találat a kereséshez.' }); // Ha üres a válasz, hibát jelezünk
        }
      } catch (error) {
        setData({ error: 'Hiba történt az adatok betöltésekor.' });
      }
    }
  };

  return (
    <div className="content">
      <h2>HalByHorgász</h2>
      <form onSubmit={handleSubmit} className="search-form">
        <label className="search-label">
          Horgász neve: 
          <input
            type="text"
            value={nev}
            onChange={handleInputChange}
            placeholder="Add meg a horgász nevét"
            className="search-input"
          />
        </label>
        <button className="search-button" type="submit">Keresés</button>
      </form>
  
      {data ? (
        <div className="result">
          {data.error ? (
            <p className="error-message">{data.error}</p>
          ) : (
            <>
              <p><strong>Név:</strong> {data.horgaszNev || 'Nincs adat'}</p>
              <p><strong>Hal Neve:</strong> {data.halNev || 'Nincs adat'}</p>
              <p><strong>Dátum:</strong> {data.datum || 'Nincs adat'}</p>
            </>
          )}
        </div>
      ) : (
        <p>{nev ? 'Betöltés...' : 'Add meg a nevet a kereséshez'}</p>
      )}
    </div>
  );
  
};



const Top3Hal = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    const loadData = async () => {
      const result = await fetchData('https://localhost:7113/harom-legnagyobb');
      setData(result);
    };
    loadData();
  }, []);

  return (
    <div className="content">
      <h2>Top 3 Hal</h2>
      {data ? (
        <div>
          {data.map((item, index) => (
            <div key={index}>
              <p><strong>Név:</strong> {item.name}</p>
              <p><strong>Méret:</strong> {item.meretCm} cm</p>
              {/* Add more fields if needed */}
              <hr />
            </div>
          ))}
        </div>
      ) : (
        <p>Betöltés...</p>
      )}
    </div>
  );
};

const App = () => {
  return (
    <Router>
      <div className="app">
        <header className="header">
          <h1>Halak</h1>
        </header>

        <nav className="navbar">
          <ul>
            <li><Link to="/halak-estavuk">Halak és Tavuk</Link></li>
            <li><Link to="/halbyhorgasz/:nev">HalByHorgász</Link></li>
            <li><Link to="/top3hal">Top3Hal</Link></li>
          </ul>
        </nav>

        <main>
          <Routes>
            <Route path="/halak-estavuk" element={<HalakEsTavuk />} />
            <Route path="/halbyhorgasz/:nev" element={<HalByHorgasz />} />
            <Route path="/top3hal" element={<Top3Hal />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
};

export default App;
