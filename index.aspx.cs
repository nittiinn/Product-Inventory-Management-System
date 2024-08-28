using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
            CreateGraph();
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            
            if (!string.IsNullOrEmpty(txtProductName.Text) &&
                !string.IsNullOrEmpty(txtCompanyName.Text) &&
                !string.IsNullOrEmpty(txtCompanyAddress.Text) &&
                !string.IsNullOrEmpty(txtProductionDate.Text) &&
                !string.IsNullOrEmpty(txtQuantity.Text) &&
                ddShift.SelectedIndex > 0)  
            {
                SqlCommand cmd = new SqlCommand("Usp_InsertProductionData", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text);
                cmd.Parameters.AddWithValue("@CompanyAddress", txtCompanyAddress.Text);
                cmd.Parameters.AddWithValue("@ProductionDate", txtProductionDate.Text);
                cmd.Parameters.AddWithValue("@Quantity", txtQuantity.Text);
                cmd.Parameters.AddWithValue("@Shift", ddShift.SelectedValue);




                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    BindGrid();
                    lblMsg.Text = "Data inserted successfully.";
                }
               
                catch (Exception ex)
                {
                   
                    lblMsg.Text = "An error occurred: " + ex.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
            else
            {
                string script = "alert('Please fill in all the required fields..');";
                ClientScript.RegisterStartupScript(this.GetType(), "SearchAlert", script, true);               
                //Page.Response.Redirect(Page.Request.Url.ToString());
            }

        }

    }



    protected void CreateGraph()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<h1>Product Quantity Data</h1>");
        sb.Append("<div class=\"text-center buttons\">");
        sb.Append("</div>");
        sb.Append("<canvas id=\"productChart\"></canvas>");
        sb.Append("<script src='https://cdn.jsdelivr.net/npm/chart.js'></script>");
        sb.Append("<script>");
        sb.Append("var ctx = document.getElementById('productChart').getContext('2d');");
        sb.Append("var productChart = new Chart(ctx, {");
        sb.Append("    type: 'bar',");
        sb.Append("    data: {");
        sb.Append("        labels: [],");
        sb.Append("        datasets: [{");
        sb.Append("            label: 'Product Quantity',");
        sb.Append("            data: [],");
        sb.Append("            backgroundColor: 'deepskyblue',");
        sb.Append("            borderColor: 'black',");
        sb.Append("            borderWidth: 1");
        sb.Append("        }]");
        sb.Append("    },");
        sb.Append("    options: {");
        sb.Append("        responsive: true,");
        sb.Append("        plugins: {");
        sb.Append("            legend: {");
        sb.Append("                position: 'top'");
        sb.Append("            },");
        sb.Append("            tooltip: {");
        sb.Append("                callbacks: {");
        sb.Append("                    label: function(context) {");
        sb.Append("                        var label = context.dataset.label || '';");
        sb.Append("                        if (label) {");
        sb.Append("                            label += ': ';");
        sb.Append("                        }");
        sb.Append("                        if (context.parsed.y !== null) {");
        sb.Append("                            label += context.parsed.y.toLocaleString();");
        sb.Append("                        }");
        sb.Append("                        return label;");
        sb.Append("                    }");
        sb.Append("                }");
        sb.Append("            }");
        sb.Append("        },");
        sb.Append("        scales: {");
        sb.Append("            x: {");
        sb.Append("                title: {");
        sb.Append("                    display: true,");
        sb.Append("                    text: 'Product Name'");
        sb.Append("                }");
        sb.Append("            },");
        sb.Append("            y: {");
        sb.Append("                title: {");
        sb.Append("                    display: true,");
        sb.Append("                    text: 'Quantity'");
        sb.Append("                },");
        sb.Append("                beginAtZero: true");
        sb.Append("            }");
        sb.Append("        }");
        sb.Append("    }");
        sb.Append("});");

        // Fetching data from database and passing it to JavaScript
        string connStr = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("GetProductsWithHighQuantity", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MinQuantity", 10000); // Minimum quantity filter

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                sb.Append("var data = {");
                sb.Append("    'products': {");
                sb.Append("        labels: [");

                foreach (DataRow row in dt.Rows)
                {
                    sb.Append(String.Format("'{0}',", row["ProductName"]));
                }
                sb.Length--; 
                sb.Append("],");

                sb.Append("        quantities: [");

                foreach (DataRow row in dt.Rows)
                {
                    sb.Append(String.Format("{0},", row["TotalQuantity"]));
                }
                sb.Length--; 
                sb.Append("]");
                sb.Append("    }");
                sb.Append("};");

                sb.Append("function showProducts() {");
                sb.Append("    productChart.data.labels = data['products'].labels;");
                sb.Append("    productChart.data.datasets[0].data = data['products'].quantities;");
                sb.Append("    productChart.update();");
                sb.Append("}");

                sb.Append("showProducts();");
            }
            else
            {
                sb.Append("document.getElementById('productChart').style.display = 'none';");
            }
        }

        sb.Append("</script>");

        containerClient.InnerHtml = sb.ToString();
    }






    private void BindGrid(string searchProductName = "")
    {
        string connStr = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("USP_GetCombinedData", conn); 
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();

        
            GridView1.Visible = dt.Rows.Count > 0;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string ProductName = txtSearch.Text.Trim(); 

        if (!string.IsNullOrEmpty(ProductName))
        {
            BindGridView1(ProductName); 
        }
        else
        {
            string script = "alert('Please enter a product name to search.');";
            
            ClientScript.RegisterStartupScript(this.GetType(), "SearchAlert", script, true);         
        }

        productSearch.Visible = true;
        cardThree.Visible = false;
        cardOne.Visible = false;
        cardtwo.Visible = false;
    }

    private void BindGridView1(string ProductName)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand cmd = new SqlCommand("GetProductDetailsByName", conn);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ProductName", ProductName);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            try
            {
                conn.Open();
                sda.Fill(dt); 

                GridView2.DataSource = dt;
                GridView2.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "An error occurred: " + ex.Message;
                
            }
        }
    }

    protected void btnfirst_Click(object sender, EventArgs e)
    {
        cardThree.Visible = false;
        cardOne.Visible = true;
        cardtwo.Visible = false ;
        productSearch.Visible = false;
    }

    protected void btnSecond_Click(object sender, EventArgs e)
    {
        cardThree.Visible = false;
        cardOne.Visible = false;
        cardtwo.Visible = true;
        productSearch.Visible = false;
    }

    protected void btnThird_Click(object sender, EventArgs e)
    {
        cardThree.Visible = true;
        cardOne.Visible = false;
        cardtwo.Visible = false;
        productSearch.Visible = false;
    }
}
