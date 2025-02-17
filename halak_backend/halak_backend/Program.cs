
using halak_backend.Models;
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;

namespace halak_backend
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // CORS beállítások hozzáadása a kívánt módon
            builder.Services.AddCors(c =>
            {
                c.AddPolicy("AllowOrigin", options =>
                    options.AllowAnyOrigin()  // Engedélyezi az összes origin-t
                           .AllowAnyMethod()  // Engedélyezi az összes HTTP metódust
                           .AllowAnyHeader()); // Engedélyezi az összes HTTP fejléceket
            });


            builder.Services.AddControllers().AddJsonOptions(x =>
                x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);



            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            // CORS middleware alkalmazása a kívánt módon
            app.UseCors(options =>
                options.AllowAnyOrigin()  // Engedélyezi az összes origin-t
                       .AllowAnyMethod()  // Engedélyezi az összes HTTP metódust
                       .AllowAnyHeader()); // Engedélyezi az összes HTTP fejléceket

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
