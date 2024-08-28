<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Company Production</title>
    <link href="style.css" rel="stylesheet" />
    <style>
        body {
            background-color: #A6B37D;
            margin: 0;
            padding: 0;
        }

        .container {
            border: 1px solid #ddd;
            box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 8px;
            padding: 20px;
            border-radius: 8px;
            background-color: whitesmoke;
            margin-top: 10px;
        }

        .cardtwo {
            
            background-color: #808D7C;
        }

        .navbar {
            background-color: #80AF81;
            top: 0;
            width: 100%;
            box-shadow: rgba(0, 0, 0, 0.1) 0px 2px 5px;
        }

        .custom-button {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            padding: 20px;
            text-decoration: none;
        }

            .custom-button:hover {
                color: greenyellow;
            }

        .errormsg {
            text-align: center;
            color: red;
            font-size: 16px;
        }

        .searchbtn {
            border-radius:5px;
            background-color:mediumseagreen;
            color:white;
        }
        .searchbtn:hover{
             background-color:greenyellow;
             color:black;
        }
        .abc {
            margin-top: 20vh;
        }
    </style>
    <link href="bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%-- Navbar start--%>
        <nav class="navbar navbar-expand-lg navbar-custom fixed-top">
            <div class="container-fluid">
                
                <img src="grainlogo.png" height="80px" />
                <div class="d-flex px-5 ms-auto">
                    <asp:Button ID="btnfirst" CssClass="custom-button" OnClick="btnfirst_Click" Text="Fill Details" runat="server" />
                    <asp:Button ID="btnSecond" CssClass="custom-button" OnClick="btnSecond_Click" Text="Reports" runat="server" />
                    <asp:Button ID="btnThird" CssClass="custom-button" OnClick="btnThird_Click" Text="Dashboard" runat="server" />
                </div>
                <div id="navbarNav">
                    <div class="d-flex ms-auto">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control me-2" placeholder="Search Product"></asp:TextBox>
                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" CssClass="searchbtn" />
                    </div>
                </div>
            </div>
        </nav>
        <%-- Navbar End --%>
        <asp:Label ID="lblMsg" runat="server" CssClass="errormsg text-bg-success"></asp:Label>


        <div class="abc">
            <%--<div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <h1>hello</h1>
                    </div>
                    <div class="col-md-4">
                        <h1>hello</h1>
                    </div>
                    <div class="col-md-4">
                        <h1>hello</h1>
                    </div>
                </div>

            </div>--%>


            <%--FillDeteils Cardone start --%>
            <div id="cardOne" visible="true" runat="server">

                <div class="container">

                    <asp:Label ID="Label1" runat="server" CssClass="text-center text-danger d-block"></asp:Label>
                    <h3 style="color: cornflowerblue">Company Production</h3>
                    <div class="row mb-2">
                        <div class="col-12">
                            <label class="form-label">Product Name</label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Company Master -->
                    <div class="mt-4">
                        <h3 style="color: cornflowerblue">Company Master</h3>
                        <div class="row">
                            <div class="col-md-6 mt-2">
                                <label class="form-label">Company Name <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>

                            <div class="col-md-6 mt-2">
                                <label class="form-label">Company Address</label>
                                <asp:TextBox ID="txtCompanyAddress" runat="server" CssClass="form-control" AutoComplete="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <!-- Daily Production -->
                    <div>
                        <h3 style="color: cornflowerblue">Production</h3>
                        <div class="row mt-2">
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
                                <asp:DropDownList ID="ddShift" runat="server" CssClass="form-select" AutoPostBack="true">
                                    <asp:ListItem Text=""></asp:ListItem>
                                    <asp:ListItem Text="Day" Value="Day"></asp:ListItem>
                                    <asp:ListItem Text="Night" Value="Night"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="col-12 text-center mt-4">
                            <asp:Button Text="Submit" ID="btnSubmit" OnClick="Button2_Click" CssClass="searchbtn w-25" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <%--FillDeteils Cardone End --%>

            <%-- Rrports section Cardtwo start--%>
            <div class="cardtwo container" id="cardtwo" visible="false" runat="server">
                <div id="company_report">
                    <h3 class="text-center" style="color: cornflowerblue">Company Report</h3>
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-striped bg-light text-center" AutoGenerateColumns="true">
                    </asp:GridView>
                </div>
            </div>
            <%-- Rrports section Cardtwo End--%>

            <div id="productSearch" visible="false" class="container mt-2" runat="server">
                <h3 style="color: cornflowerblue">Product Data</h3>
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
                <div id="containerClient" class="container w-75" runat="server">
                </div>
            </div>
            <%-- Dashboard seaction End --%>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
