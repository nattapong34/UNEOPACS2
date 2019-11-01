<%@ Page Title="UNEO2.0:Study" Language="C#" MasterPageFile="~/uneo.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UNEOPACS2.Study.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-grid.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-select.css" rel="stylesheet" />
    <link href="../Scripts/DataTables/datatables.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Scripts/MDB-Free_4.8.10/css/mdb.min.css" rel="stylesheet" />
    <link href="../Content/font-awesome.css" rel="stylesheet" />
    <link href="../Content/uikit.min.css" rel="stylesheet" />
    <link href="../Content/dataTables.uikit.min.css" rel="stylesheet" />


    <script src="../Scripts/jquery-3.4.1.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
    <script src="../Scripts/bootstrap-select.js"></script>
    <script src="../Scripts/DataTables/datatables.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/locales/bootstrap-datepicker.th.min.js"></script>
    <script src="../Scripts/MDB-Free_4.8.10/js/mdb.min.js"></script>
    <script src="../Scripts/jquery.confirm.min.js"></script>
    <script src="../Scripts/tinymce/tinymce.min.js"></script>


    <div id="body">
        <div class="cloudy-knoxville-gradient">
            <div class="rgba-cyan-slight">

                <div class="form-group">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-2">
                                <div class="md-form">
                                    <asp:TextBox ID="txtID" runat="server" CssClass="form-control"></asp:TextBox>
                                    <label for="txtID">HN</label>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="md-form">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <label for="txtName">ชื่อ</label>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="input-daterange input-group" id="datepicker">
                                    <div class="md-form">
                                        <asp:TextBox ID="txtDt1" runat="server" CssClass="form-control"></asp:TextBox>
                                        <label for="txtDt1">วันที่</label>
                                    </div>
                                    <div class="md-form">
                                        <asp:TextBox ID="txtDt2" runat="server" CssClass="form-control"></asp:TextBox>
                                        <label for="txtDt2">ถึง</label>
                                    </div>

                                </div>
                            </div>
                            <script>
                                $(function () {
                                    $('.input-daterange').datepicker({
                                        language: 'th-th', format: 'dd/mm/yyyy', todayBtn: "linked",
                                        todayHighlight: true
                                    })
                                });
                            </script>
                            <div class="col-lg-4">
                                <div class="md-form">
                                    <asp:TextBox ID="txtDoc" runat="server" CssClass="form-control"></asp:TextBox>
                                    <label for="txtDoc">แพทย์/เจ้าหน้าที่</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3">
                                <div class="md-form">
                                    <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"></asp:TextBox>
                                    <label for="txtDesc">รายการ</label>
                                </div>
                            </div>
                            <asp:CheckBoxList ID="cbMod" runat="server"
                                BorderStyle="None" Font-Bold="True" Font-Names="Arial" Font-Size="Small"
                                ForeColor="Black" RepeatDirection="Horizontal" Width="356px" CssClass="btn-group btn-group-toggle">
                                <asp:ListItem Selected="True">CR</asp:ListItem>
                                <asp:ListItem Selected="True">DX</asp:ListItem>
                                <asp:ListItem Selected="True">CT</asp:ListItem>
                                <asp:ListItem Selected="True">MR</asp:ListItem>
                                <asp:ListItem Selected="True">US</asp:ListItem>
                                <asp:ListItem Selected="True">NM</asp:ListItem>
                                <asp:ListItem Selected="True">XA</asp:ListItem>
                                <asp:ListItem Selected="True">MG</asp:ListItem>
                                <asp:ListItem Selected="True">CS</asp:ListItem>
                                <asp:ListItem Selected="True">MD</asp:ListItem>
                            </asp:CheckBoxList>
                            <div class="col-lg-4">
                                <asp:Button ID="bnToday" runat="server" Text="วันนี้" CssClass="btn aqua-gradient mb-4" OnClick="bnToday_Click" />
                                <asp:Button ID="bnYesterday" runat="server" Text="เมื่อวาน" CssClass="btn peach-gradient mb-4" OnClick="bnYesterday_Click" />
                                <asp:Button ID="bnFind" runat="server" Text="ค้นหา" CssClass="btn blue-gradient mb-4" OnClick="bnFind_Click" />
                                <script>
                                    $("#<%= bnFind.ClientID %>").click(function () {
                                        var id = $("#<%= txtID.ClientID %>").val();
                                        var name = $("#<%= txtName.ClientID %>").val();
                                        var dt1 = $("#<%= txtDt1.ClientID %>").val();
                                        var dt2 = $("#<%= txtDt2.ClientID %>").val();
                                        var doc = $("#<%= txtDoc.ClientID %>").val();
                                        var desc = $("#<%= txtDesc.ClientID %>").val();

                                        if (id.length == 0 && name.length == 0 && dt1.length == 0 && dt2.length == 0 && doc.length == 0 && desc.length == 0) {
                                            //ConfirmDialog('กรุณายืนยันการค้นหาแบบไม่มีเงื่อนไข<br>ระบบจะประมวลผลช้า เนื่องจากแสดงรายการทั้งหมด');
                                            if (confirm("ต้องการค้นหาแบบไม่มีเงื่อนไข?\nข้อมูลจะถูกแสดงทั้งหมด!! กรุณายืนยัน")) {
                                                return true;
                                            }
                                            else {
                                                return false;
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <table id="tbStudy" class="uk-table uk-table-hover uk-table-striped" cellspacing="0" style="width: 100%">
                <thead>
                    <tr>
                        <th>HN</th>
                        <th>VN</th>
                        <th>ชื่อ</th>
                        <th>วันที่</th>
                        <th>เวลา</th>
                        <th>รายละเอียด</th>
                        <th>ซีรี่/ภาพ</th>
                        <th>MOD</th>
                        <th>วันเกิด/อายุ</th>
                        <th>แพทย์/เจ้าหน้าที่</th>
                        <th>รายงาน</th>
                        <th>ดูภาพ</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (db.ds.Tables["study"] != null)
                            foreach (System.Data.DataRow dr in db.ds.Tables["study"].Rows)
                            { %>
                    <tr>
                        <td class=" text-dark">
                            <p class="font-weight-bold"><%=dr["PatientID"].ToString() %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=dr["vn"].ToString() %></p>
                        </td>
                        <td>
                            <p class="font-weight-bold"><%=formatName(dr["PatientsName"].ToString()) %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=formatDate(dr["StudyDate"].ToString()) %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=formatTime(dr["StudyTime"].ToString()) %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=dr["StudyDescription"].ToString() %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=dr["NumberOfStudyRelatedSeries"].ToString() + "/" + dr["NumberOfStudyRelatedInstances"].ToString()  %></p>
                        </td>
                        <td>
                            <p class="font-weight-bold"><%=dr["Modality"].ToString() %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%= CalAge(dr["PatientsBirthDate"].ToString(),dr["StudyDate"].ToString()) %></p>
                        </td>
                        <td>
                            <p class="font-weight-light"><%=dr["ReferringPhysiciansName"].ToString().Replace('^', ' ') %></p>
                        </td>
                        <td>
                            <% if (string.IsNullOrEmpty(dr["ondate"].ToString()))
                                { %>
                            <a data-toggle="modal" data-target="#mdReport" class="btn btn-secondary px-3 bnrpt"
                                data-id="<%=dr["StudyInstanceUid"].ToString() +"|" +dr["PatientID"].ToString()+"|" +dr["PatientsName"].ToString() +"|"+dr["StudyDescription"].ToString() +"|"+ formatDate(dr["StudyDate"].ToString())  +"|"+ formatTime(dr["StudyTime"].ToString()) %>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                            <%}
                                else
                                { %>
                            <p><strong><%=dr["ondate"].ToString() %></strong></p>
                            <%} %>
                        </td>
                        <td><a class="btn btn-indigo" target="_blank" href="<%=pacsLink(dr["Modality"].ToString(),dr["urlview"].ToString()) %>" role="button"><i class="fa fa-eye" aria-hidden="true"></i></a></td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <th>HN</th>
                        <th>VN</th>
                        <th>ชื่อ</th>
                        <th>วันที่</th>
                        <th>เวลา</th>
                        <th>รายละเอียด</th>
                        <th>ซีรี่/ภาพ</th>
                        <th>MOD</th>
                        <th>วันเกิด/อายุ</th>
                        <th>แพทย์/เจ้าหน้าที่</th>
                        <th>รายงาน</th>
                        <th>ดูภาพ</th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>


    <!-- Modal report -->
    <div id="mdReport" class="modal fade" role="dialog">
        <div class="modal-dialog modal-xl modal-full-height modal-top modal-notify modal-warning">
            <input type="hidden" class="form-control-plaintext" name="stuid" id="stuid" value="" />
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="navbar-brand mb-0 h1">
                        <span class="text-center">
                            <i class="fa fa-pencil-square-o"></i>
                            ผลการอ่าน
                        </span></span>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <div class="form-row">
                        <div class="col-2">
                            <p>HN</p>
                        </div>
                        <div class="col-3">
                            <input type="text" class="form-control-plaintext" name="hn" id="hn" value="" />
                        </div>
                        <div class="col-2">
                            <p>ชื่อ</p>
                        </div>
                        <div class="col-3">
                            <input type="text" class="form-control-plaintext" name="name" id="name" value="" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label">วันเวลา</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control-plaintext" name="dt" id="dt" value="" />
                        </div>
                    </div>
                   <div align="right">
                        <div class="row">    
                            <div class="col-sm">
                                &nbsp; &nbsp; &nbsp; &nbsp;
                            </div>
                            <!-- Default inline 1-->
                            <div class="col-sm">
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" id="defaultInline1" name="inlineDefaultRadiosExample">
                                    <label class="custom-control-label" for="defaultInline1">ปกติ</label>
                                </div>
                            </div>

                            <!-- Default inline 2-->
                            <div class="col-sm">
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" id="defaultInline2" name="inlineDefaultRadiosExample">
                                    <label class="custom-control-label" for="defaultInline2">ผิดปกติ</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="w-100 p-3" style="height: 380px;">
                            <textarea id="txtMemmo" name="mytextarea"> </textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Popup -->

    <script>
        $(function () {
            tinymce.init({
                selector: '#txtMemmo',
                height: 350
            });

            $("#mdReport").on('shown.bs.modal', function () {
                var txt = $('#stuid').val().split("|");

                var id = txt[0];
                var hn = txt[1];
                var name = txt[2];
                var desc = txt[3];
                var dt = txt[4];
                var tm = txt[5];

                $('#hn').val(hn);
                $('#name').val(name);
                $('#desc').val(desc);
                $('#dt').val(dt + ' ' + tm);

                //alert(id + " " + hn + " " + name);

            });

            $(document).on("click", ".bnrpt", function () {
                var myBookId = $(this).data('id');
                $("#stuid").val(myBookId);
            });

            var table = $("#tbStudy").DataTable(
                {
                    'responsive': true,
                    scrollY: '50vh',
                    scrollCollapse: true,
                    paging: false,
                    "language": {
                        "lengthMenu": "Display _MENU_ records per page",
                        "zeroRecords": "ไม่พบข้อมูล",
                        // "info": "หน้าที่ _PAGE_ / _PAGES_",
                        "infoEmpty": "ไม่พบรายการที่แสดง",
                        "infoFiltered": "(filtered from _MAX_ total records)"
                    }
                });

        });
        function ConfirmDialog(message) {
            $('<div></div>').appendTo('body')
                .html('<div><h6>' + message + '?</h6></div>')
                .dialog({
                    modal: true,
                    title: 'Delete message',
                    zIndex: 10000,
                    autoOpen: true,
                    width: 'auto',
                    resizable: false,
                    buttons: {
                        Yes: function () {
                            // $(obj).removeAttr('onclick');                                
                            // $(obj).parents('.Parent').remove();

                            $('body').append('<h1>Confirm Dialog Result: <i>Yes</i></h1>');

                            $(this).dialog("close");
                        },
                        No: function () {
                            $('body').append('<h1>Confirm Dialog Result: <i>No</i></h1>');

                            $(this).dialog("close");
                        }
                    },
                    close: function (event, ui) {
                        $(this).remove();
                    }
                });
        };
    </script>
</asp:Content>
