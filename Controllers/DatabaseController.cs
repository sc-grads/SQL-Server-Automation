using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Data;
using SqlApi.Model; 

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

   [HttpPost("insert")]
public IActionResult InsertUser([FromBody] User user)
{
    try
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            string query = "EXEC InsertUser @Name, @Surname, @Email";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Name", user.Name);
                cmd.Parameters.AddWithValue("@Surname", user.Surname);
                cmd.Parameters.AddWithValue("@Email", user.Email);
                cmd.ExecuteNonQuery();
            }
        }
        return Ok("User inserted successfully!");
    }
    catch (Exception ex)
    {
        return StatusCode(500, ex.Message);
    }
}

[HttpGet("get/{id}")]
public IActionResult GetUser(int id)
{
    try
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            string query = "SELECT * FROM [dbo].[user] WHERE ID = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        var user = new
                        {
                            Id = reader["ID"],
                            Name = reader["Name"],
                            Surname = reader["Surname"],
                            Email = reader["Email"]
                        };
                        return Ok(user);
                    }
                    else
                    {
                        return NotFound("User not found.");
                    }
                }
            }
        }
    }
    catch (Exception ex)
    {
        return StatusCode(500, ex.Message);
    }
}


[HttpGet("get-all")]
public IActionResult GetAllUsers()
{
    try
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            string query = "SELECT * FROM [dbo].[user]";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var users = new List<object>();
                    while (reader.Read())
                    {
                        users.Add(new
                        {
                            Id = reader["ID"],
                            Name = reader["Name"],
                            Surname = reader["Surname"],
                            Email = reader["Email"]
                        });
                    }
                    return Ok(users);
                }
            }
        }
    }
    catch (Exception ex)
    {
        return StatusCode(500, ex.Message);
    }
}

[HttpPut("update/{id}")]
public IActionResult UpdateUser(int id, [FromBody] User user)
{
    try
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            string query = "UPDATE [dbo].[user] SET Name = @Name, Surname = @Surname, Email = @Email WHERE ID = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Parameters.AddWithValue("@Name", user.Name);
                cmd.Parameters.AddWithValue("@Surname", user.Surname);
                cmd.Parameters.AddWithValue("@Email", user.Email);
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return Ok("User updated successfully!");
                }
                else
                {
                    return NotFound("User not found.");
                }
            }
        }
    }
    catch (Exception ex)
    {
        return StatusCode(500, ex.Message);
    }
}
}