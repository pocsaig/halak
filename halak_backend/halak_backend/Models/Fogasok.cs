using System;
using System.Collections.Generic;

namespace halak_backend.Models;

public partial class Fogasok
{
    public int Id { get; set; }

    public int HalId { get; set; }

    public int HorgaszId { get; set; }

    public DateTime Datum { get; set; }

    public virtual Halak Hal { get; set; } = null!;

    public virtual Horgaszok Horgasz { get; set; } = null!;
}
