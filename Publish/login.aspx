<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="UNEOPACS2.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UNEO2.0</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="icon" type="image/png" href="favicon.ico" />
    <link href="Scripts/Login_v20/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/fonts/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/fonts/Linearicons-Free-v1.0.0/icon-font.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/vendor/animate/animate.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/vendor/css-hamburgers/hamburgers.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/vendor/animsition/css/animsition.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/vendor/select2/select2.min.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/vendor/daterangepicker/daterangepicker.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/css/util.css" rel="stylesheet" />
    <link href="Scripts/Login_v20/css/main.css" rel="stylesheet" />

    <script src="Scripts/Login_v20/vendor/jquery/jquery-3.2.1.min.js"></script>
    <link href="Scripts/Login_v20/vendor/animsition/css/animsition.min.css" rel="stylesheet" />
    <script src="Scripts/Login_v20/vendor/bootstrap/js/popper.js"></script>
    <script src="Scripts/Login_v20/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="Scripts/Login_v20/vendor/select2/select2.min.js"></script>
    <script src="Scripts/Login_v20/vendor/daterangepicker/moment.min.js"></script>
    <script src="Scripts/Login_v20/vendor/daterangepicker/daterangepicker.js"></script>
    <script src="Scripts/Login_v20/vendor/countdowntime/countdowntime.js"></script>
    <script src="Scripts/Login_v20/js/main.js"></script>

</head>
<body>
    <style type="text/css">
        .messagealert {
            width: 100%;
            position: fixed;
            top: 0px;
            z-index: 100000;
            padding: 0;
            font-size: 15px;
        }
    </style>
    <div class="limiter">
        <div class="container-login100">


            <div class="wrap-login100 p-b-160 p-t-200">

                <form class="login100-form validate-form" runat="server">
                    <span class="login100-form-title p-b-43">
                        <img src="media/uneo.png" />
                        Account Login
                    </span>

                    <div class="wrap-input100 rs1 validate-input" data-validate="Username is required">
                        <asp:TextBox ID="txtUser" runat="server" CssClass="input100"></asp:TextBox>
                        <span class="label-input100">User name</span>
                    </div>


                    <div class="wrap-input100 rs2 validate-input" data-validate="Password is required">
                        <asp:TextBox ID="txtPass" runat="server" CssClass="input100" TextMode="Password"></asp:TextBox>
                        <span class="label-input100">Password</span>
                    </div>

                    <div class="container-login100-form-btn">
                        <asp:Button ID="bnSingin" runat="server" Text="เข้าสู่ระบบ" CssClass="login100-form-btn" OnClick="bnSingin_Click" />
                    </div>
                    <div class="text-center w-full p-t-23">
                        <button type="button" class="btn btn-outline-dark btn-sm" data-toggle="modal" data-target="#mdCreateuser" data-whatever="@fat">สมัครสมาชิก</button>
                        <%--<button type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#mdChangepass" data-whatever="@fat">เปลี่ยนรหัสผ่าน</button>--%>
                    </div>
                    <div class="fixed-bottom">
                        <div class="container-login100-form-btn">
                            <a href="media/Silverlight.exe" class="text-light">Silverlight</a>
                        </div>
                        <div class="text-center w-full p-t-23">
                            <asp:Label ID="lbAbount" runat="server" Text="."></asp:Label>
                        </div>
                    </div>
                    <div>
                    </div>

                    <%--modal create user--%>

                    <div class="modal fade" id="mdCreateuser" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">สมัครสมาชิกใหม่</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="recipient-name" class="col-form-label">ชื่อจริงผู้ใช้งาน:</label>
                                        <asp:TextBox ID="txtFullname" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">User name:</label>
                                        <asp:TextBox ID="txtcUser" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">Password:</label>
                                        <asp:TextBox ID="txtcPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="bncCancel" runat="server" Text="ยกเลิก" CssClass="btn btn-secondary" data-dismiss="modal" />
                                    <asp:Button ID="bncAdd" runat="server" Text="บันทึก" CssClass="btn btn-primary" OnClick="bncAdd_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--End modal create user--%>

                    <%--modal changepass--%>

                    <div class="modal fade" id="mdChangepass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel2">เปลี่ยนรหัสผ่าน</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">User name :</label>
                                        <asp:TextBox ID="txtcpUser" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">Password เก่า :</label>
                                        <asp:TextBox ID="txtcpPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="message-text" class="col-form-label">Password ใหม่ :</label>
                                        <asp:TextBox ID="txtcpNewpass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="Button1" runat="server" Text="ยกเลิก" CssClass="btn btn-secondary" data-dismiss="modal" />
                                    <asp:Button ID="bncpAdd" runat="server" Text="บันทึก" CssClass="btn btn-primary" OnClick="bncpAdd_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--End modal changepass--%>
                </form>
            </div>


        </div>
    </div>

    <!-- Modal Popup -->
    <div id="MyPopup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Popup -->


    <script type="text/javascript"> 

        function ShowPopup(title, body) {
            $("#MyPopup .modal-title").html(title);
            $("#MyPopup .modal-body").html(body);
            $("#MyPopup").modal("show");
        }

        function openModal(message, messagetype) {
            var cssclass;
            switch (messagetype) {
                case 'Success':
                    cssclass = 'alert-success'
                    break;
                case 'Error':
                    cssclass = 'alert-danger'
                    break;
                case 'Warning':
                    cssclass = 'alert-warning'
                    break;
                default:
                    cssclass = 'alert-info'
            }
            $('#alert_container').append('<div id="alert_div" style="margin: 0 0.5%; -webkit-box-shadow: 3px 4px 6px #999;" class="alert fade in ' + cssclass + '"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>' + messagetype + '!</strong> <span>' + message + '</span></div>');
            // $('#alert_container').modal('show');
        }

    </script>
</body>
</html>
