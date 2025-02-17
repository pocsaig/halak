
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

            // CORS be�ll�t�sok hozz�ad�sa a k�v�nt m�don
            builder.Services.AddCors(c =>
            {
                c.AddPolicy("AllowOrigin", options =>
                    options.AllowAnyOrigin()  // Enged�lyezi az �sszes origin-t
                           .AllowAnyMethod()  // Enged�lyezi az �sszes HTTP met�dust
                           .AllowAnyHeader()); // Enged�lyezi az �sszes HTTP fejl�ceket
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

            // CORS middleware alkalmaz�sa a k�v�nt m�don
            app.UseCors(options =>
                options.AllowAnyOrigin()  // Enged�lyezi az �sszes origin-t
                       .AllowAnyMethod()  // Enged�lyezi az �sszes HTTP met�dust
                       .AllowAnyHeader()); // Enged�lyezi az �sszes HTTP fejl�ceket

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
