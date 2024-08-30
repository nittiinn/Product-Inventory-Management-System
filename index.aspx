<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Company Production</title>
    <link href="bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link href="style.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Sidebar start -->
        <div class="sidebar" id="sidebar">
            <span class="close-btn" onclick="toggleSidebar()">×</span>
            <div class="profile-section">
                <img src="profilelogo.png" alt="Profile Picture" height="60px;">
            </div>
            <asp:Button ID="btnHome" OnClick="btnHome_Click" CssClass="custom-button" Text="Home" runat="server" />
            <asp:Button ID="btnThird" CssClass="custom-button" OnClick="btnThird_Click" Text="Dashboard" runat="server" />
            <asp:Button ID="btnSecond" CssClass="custom-button" OnClick="btnSecond_Click" Text="Reports" runat="server" />
            <asp:Button ID="btnfirst" CssClass="custom-button" OnClick="btnfirst_Click" Text="Add Product" runat="server" />
            <a href="#">Settings</a>
            <a href="login.aspx">Log out</a>
        </div>


        <div class="main-content" id="mainContent">
            <!-- Navbar -->
            <nav class="navbar-custom">
                <div class="navbar-left">
                    <div class="search-container">
                        <span class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</span>
                        <div class="search-wrapper">
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-bar" placeholder="Search Product"></asp:TextBox>
                            <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="🔍" CssClass="search-button" />
                        </div>
                    </div>
                </div>
                <a href="#" class="custom-button">
                    <i class="fas text-white fa-user-circle"></i>
                    <span style="text-decoration: none; color: white;">User</span>
                </a>
            </nav>
            <asp:Label ID="lblMsg" runat="server" CssClass="errormsg text-bg-success"></asp:Label>

            <!-- Main Dashboard Content -->
            <div class="dashboard-content">


                <!-- Hero Section -->
                <section id="hero" runat="server" class="hero section">

                    <div class="container">
                        <div class="row gy-4">
                            <div class="col-lg-6 order-lg-last">
                                <img src="hero-img.png" class="img-fluid" alt="">
                            </div>
                            <div class="col-lg-6  d-flex flex-column justify-content-center">
                                <h3>"Optimizing Efficiency and Quality: Mastering Production Management for Success"</h3>
                                <ul>
                                    <li><i class="bi bi-check2"></i>Maximizes Efficiency</li>
                                    <li><i class="bi bi-check2"></i>Ensures Quality</li>
                                    <li><i class="bi bi-check2"></i>Enhances Competitiveness</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </section>
                <!-- /Hero Section -->



                <%--FillDeteils Cardone start --%>
                <div id="cardOne" class="cardone container" visible="true" runat="server">
                    <asp:Label ID="Label1" runat="server" CssClass="text-center text-danger d-block"></asp:Label>

                    <fieldset>
                        <legend>Company Production:</legend>
                        <div class="row p-4">
                            <div class="col-md-2">
                                <label class=" form-label mx-3">Product Name<span class="text-danger">*</span></label>
                            </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Add Product " AutoComplete="true"></asp:TextBox>
                            </div>
                        </div>
                    </fieldset>


                    <fieldset class="mt-5">
                        <legend>Company Master:</legend>
                        <div class="row p-4">
                            <div class="col-md-6 mt-2">
                                <label class="form-label">Company Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class="form-label">Company Address</label>
                                <asp:TextBox ID="txtCompanyAddress" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>
                        </div>
                    </fieldset>

                    <fieldset class="mt-5">
                        <legend>Production</legend>
                        <div class="row p-4">
                            <div class="col-md-4">
                                <label class="form-label">Date <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtProductionDate" type="date" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4 ">
                                <label class="form-label">Product Quantity <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Shift <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddShift" runat="server" CssClass="form-control form-select" AutoPostBack="true">
                                    <asp:ListItem Text="select"></asp:ListItem>
                                    <asp:ListItem Text="Day" Value="Day"></asp:ListItem>
                                    <asp:ListItem Text="Night" Value="Night"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </fieldset>

                    <div class="col-12 text-center mt-4">
                        <asp:Button Text="Submit" ID="btnSubmit" OnClick="Button2_Click" CssClass="searchbtn btn btn-info w-25" runat="server" />
                    </div>
                </div>

                <%--FillDeteils Cardone End --%>

                <%-- Rrports section Cardtwo start--%>
                <div class="cardtwo container" id="cardtwo" visible="false" runat="server">
                    <div id="company_report">
                        <h3 class="text-center" style="color: black;">Company Report</h3>
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-striped bg-light text-center" AutoGenerateColumns="true">
                        </asp:GridView>
                    </div>
                </div>
                <%-- Rrports section Cardtwo End--%>

                <div id="productSearch" visible="false" class="containerr mt-2" style="height:350px;" runat="server">
                    <h3>Product Data</h3>
                    <asp:Label ID="lblErrorMessage" runat="server" />
                    <asp:GridView ID="GridView2" runat="server" CssClass="table table-bordered table-striped bg-light text-center" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" HeaderStyle-BackColor="#EEEDEB" />
                            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
                            <asp:BoundField DataField="CompanyAddress" HeaderText="Company Address" />
                            <asp:BoundField DataField="ProductionDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="Quantity" HeaderText="Product Quantity" />
                            <asp:BoundField DataField="Shift" HeaderText="Shift" />
                        </Columns>
                    </asp:GridView>
                </div>

                <%-- Dashboard seaction start --%>
                <div id="cardThree" visible="false" runat="server">
                    <div id="containerClient" class="container" runat="server">
                    </div>
                </div>
                <%-- Dashboard seaction End --%>
            </div>
            <footer id="footer" class="footer">
                <div class="container copyright text-center mt-4">
                    <p>© <span>Copyright</span> <strong class="px-1 sitename">Product Management</strong> <span>All Rights Reserved</span></p>
                    <div class="credits">
                        Designed by <a href="https://www.linkedin.com/in/nitin-patel-a08501225">Nitin Patel</a>
                    </div>
                </div>
            </footer>
        </div>

    </form>



    <script>
        function openNav() {
            document.getElementById("sidebar").classList.add('open');
        }

        function closeNav() {
            document.getElementById("sidebar").classList.remove('open');
        }

        function showSection(sectionId) {
            // Hide all sections
            document.querySelectorAll('.container[id]').forEach(el => el.style.display = 'none');

            // Show the selected section
            document.getElementById(sectionId).style.display = 'block';
        }
        // JavaScript to handle sidebar toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('mainContent');

            sidebar.classList.toggle('closed');
            mainContent.classList.toggle('expanded');
        }

        // Add event listener to adjust content on window resize
        window.addEventListener('resize', function () {
            if (window.innerWidth > 768) {
                document.getElementById('sidebar').classList.remove('closed');
                document.getElementById('mainContent').classList.remove('expanded');
            }
        });

    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="sidebar.js"></script>
</body>
</html>
