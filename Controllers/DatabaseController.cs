using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;

[Route("api/database")]
[ApiController]
public class DatabaseController : ControllerBase
{
    private readonly string _connectionString;

    public DatabaseController(IConfiguration configuration)
    {
         _connectionString = configuration.GetConnectionString("DefaultConnection") 
                            ?? throw new ArgumentNullException(nameof(configuration), "Connection string is missing.");
    }

    [HttpGet("test")]
    public IActionResult TestConnection()
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                return Ok("SQL Server connection successful!");
            }
        }
        catch (Exception ex)
        {
            return StatusCode(500, ex.Message);
        }
    }
}
