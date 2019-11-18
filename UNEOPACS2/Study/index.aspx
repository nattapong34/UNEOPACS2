<%@ Page Title="UNEO2.0:Study" Language="C#" MasterPageFile="~/uneo.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="UNEOPACS2.Study.index" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<link href="../Content/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap-grid.min.css" rel="stylesheet" />
    <%--<link href="../Content/bootstrap-select.css" rel="stylesheet" />--%>

    <link href="../Scripts/DataTables/datatables.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <link href="../Scripts/MDB-Free_4.8.10/css/mdb.min.css" rel="stylesheet" />
    <link href="../Content/font-awesome.css" rel="stylesheet" />
    <link href="../Content/uikit.min.css" rel="stylesheet" />
    <link href="../Content/dataTables.uikit.min.css" rel="stylesheet" />
    <link href="../Scripts/bootstrap-multiselect-dropdown/css/bootstrap-multiselect.css" rel="stylesheet" />

    <script src="../Scripts/jquery-3.4.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
    <%--    <script src="../Scripts/bootstrap.min.js"></script>--%>
    <%--<script src="../Scripts/bootstrap.bundle.js"></script>--%>
    <script src="../Scripts/popper.js"></script>

    <script src="../Scripts/bootstrap-multiselect-dropdown/js/bootstrap-multiselect.js"></script>

    <script src="../Scripts/DataTables/datatables.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/locales/bootstrap-datepicker.th.min.js"></script>
    <script src="../Scripts/MDB-Free_4.8.10/js/mdb.min.js"></script>
    <script src="../Scripts/jquery.confirm.min.js"></script>
    <script src="../Scripts/tinymce/tinymce.min.js"></script>
     <script src="../Scripts/getBrowser.js"></script>
    <style>
        .btn {
            border-radius: 10px;
            position: -webkit-sticky; /* Safari */
            position: sticky;
        }

        .table-striped > tbody > tr:nth-of-type(2n+1),
        .table-striped > tbody > tr.odd {
            background-color: #f1f8e9;
        }

        .table-striped > tbody > tr.even {
            background-color: #FFF;
        }

        .table-hover tbody tr:hover td {
            background: #c6ff00;
        }
        .pnSearch{
background-image: linear-gradient(to top, #f2f2f2, #f1f1f3, #eff1f4, #ecf1f5, #e9f1f6, #e9f1f6, #eaf1f7, #eaf1f7, #eef2f7, #f1f3f6, #f3f4f6, #f5f5f5);
        }
    </style>



    <div id="body">

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="cloudy-knoxville-gradient shadow-sm">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <div class="shadow-sm pnSearch">
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
                                    <%--                   <div class="col-lg-4">
                                        <div class="md-form">
                                            <asp:TextBox ID="txtDoc" runat="server" CssClass="form-control" Visible="False"></asp:TextBox>
                                            <label for="txtDoc">แพทย์/เจ้าหน้าที่</label>
                                        </div>
                                    </div>--%>
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
                                    <div class="col-lg-4">
                                        <div class="md-form">
                                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"></asp:TextBox>
                                            <label for="txtDesc">รายการ</label>
                                        </div>
                                    </div>


                                </div>
                                <div class="row">

                                    <div class="col-4">
                                        <ul id="check-list-box" class="list-group checked-list-box border-0">
                                            <li class="list-group-item bg-transparent border-0">
                                                <asp:CheckBoxList ID="cbMod" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Text="CR" Value="CR"></asp:ListItem>
                                                    <asp:ListItem Text="DX" Value="DX"></asp:ListItem>
                                                     <asp:ListItem Text="CT" Value="CT"></asp:ListItem>
                                                    <asp:ListItem Text="MR" Value="MR"></asp:ListItem>
                                                    <asp:ListItem Text="US" Value="US"></asp:ListItem>
                                                    <asp:ListItem Text="NM" Value="NM"></asp:ListItem>
                                                    <asp:ListItem Text="XA" Value="XA"></asp:ListItem>
                                                    <asp:ListItem Text="MG" Value="MG"></asp:ListItem>
                                                    <asp:ListItem Text="CS" Value="CS"></asp:ListItem>
                                                    <asp:ListItem Text="MD" Value="MD"></asp:ListItem>
                                                </asp:CheckBoxList></li>
                                        </ul>
                                    </div>

                                    <div class="col align-self-end">
                                        <asp:Button ID="bnToday" runat="server" Text="วันนี้" OnClick="bnToday_Click" CssClass="btn btn-indigo font-weight-bold" />
                                        <asp:Button ID="bnYesterday" runat="server" Text="เมื่อวาน" OnClick="bnYesterday_Click" CssClass="btn btn-mdb-color font-weight-bold" />
                                        <asp:Button ID="bnFind" runat="server" Text="ค้นหา" OnClick="bnFind_Click" CssClass="btn btn-dark-green  font-weight-bold bnfind" />
                                    </div>
                                    <script>
                                        $(function () {
                                            $(document).on("click", ".bnfind", function () {
                                                var id = $("#<%= txtID.ClientID %>").val();
                                                var name = $("#<%= txtName.ClientID %>").val();
                                                var dt1 = $("#<%= txtDt1.ClientID %>").val();
                                                var dt2 = $("#<%= txtDt2.ClientID %>").val();
                                                var desc = $("#<%= txtDesc.ClientID %>").val();

                                                if (id.length == 0 && name.length == 0 && dt1.length == 0 && dt2.length == 0 && desc.length == 0) {
                                                    //ConfirmDialog('กรุณายืนยันการค้นหาแบบไม่มีเงื่อนไข<br>ระบบจะประมวลผลช้า เนื่องจากแสดงรายการทั้งหมด');
                                                    if (confirm("ต้องการค้นหาแบบไม่มีเงื่อนไข?\nข้อมูลจะถูกแสดงทั้งหมด!! กรุณายืนยัน")) {
                                                        return true;
                                                    }
                                                    else {
                                                        return false;
                                                    }
                                                }
                                            });
                                        });

                                        $(function () {
                                            $('.input-daterange').datepicker({
                                                language: 'th-th', format: 'dd/mm/yyyy', todayBtn: "linked",
                                                todayHighlight: true
                                            })
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="updateProgress" runat="server">
                <ProgressTemplate>
                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #000000; opacity: 0.7;">
                        <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #FFFFFF; font-size: 36px; left: 40%; top: 40%;">Loading ...</span>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel runat="server" ID="upStudy">
                <ContentTemplate>
                    <table id="tbStudy" class="table table-hover table-striped mb-0" cellspacing="0" style="width: 100%">
                        <thead class="mdb-color darken-3 white-text">
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
                                <th>ผล</th>
                                <th>DCM</th>
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
                                    <p class="font-weight-light"><%=formatDate(dr["StudyDate"].ToString(), false) %></p>
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
                                    <p class="font-weight-light"><%= CalAge(dr["PatientsBirthDate"].ToString(), dr["StudyDate"].ToString()) %></p>
                                </td>
                                <td>
                                    <p class="font-weight-light"><%=dr["ReferringPhysiciansName"].ToString().Replace('^', ' ') %></p>
                                </td>
                                <td>

                                    <% if (string.IsNullOrEmpty(dr["ondate"].ToString()))
                                        { %>
                                    <% if (bool.Parse(Session["report"].ToString()))
                                        { %>
                                    <a data-toggle="modal" data-target="#mdReport" class="btn  btn btn-blue-grey waves-effect px-3 bnrpt"
                                        title="เขียนรายงาน" data-id="<%=dr["StudyInstanceUid"].ToString() + "|" + dr["PatientID"].ToString() + "|" + dr["PatientsName"].ToString() + "|" + dr["StudyDescription"].ToString() + "|" + formatDate(dr["StudyDate"].ToString()) + "|" + formatTime(dr["StudyTime"].ToString()) %>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                                    <%} %>
                                    <%}
                                        else
                                        { %>

                                    <a data-toggle="modal" data-target="#mdReport" class="btn btn-deep btn-info px-3 bnrpt"
                                        title="บันทึกวันที่ <%= formatDateTime(dr["ondate"].ToString()) %>" data-id="<%=dr["StudyInstanceUid"].ToString() + "|" + dr["PatientID"].ToString() + "|" + dr["PatientsName"].ToString() + "|" + dr["StudyDescription"].ToString() + "|" + formatDate(dr["StudyDate"].ToString()) + "|" + formatTime(dr["StudyTime"].ToString()) %>"><i class="fa fa-file-text-o" aria-hidden="true"></i></a>

                                    <%} %>
                                </td>
                                <td>
                                    <% if (dr["Modality"].ToString() != "MD")
                                        { %>
                                    <button type="button" class="btn btn-deep-purple waves-effect px-3" onclick="OpenPopupCenter('download.aspx?stuid=<%=dr["StudyInstanceUid"].ToString()+"&desc="+dr["StudyDescription"].ToString() +"&hn="+dr["PatientID"].ToString() +"&name="+formatName(dr["PatientsName"].ToString()) +"&dt="+formatDate(dr["StudyDate"].ToString(), false)+"-" +formatTime(dr["StudyTime"].ToString()) %>','DICOM Download',800,400)"><i class="fa fa-download" aria-hidden="true"></i></button>
                                    <%} %>
                                </td>
                                <td><a class="btn btn-mdb-color waves-effect px-3" target="_blank" href="<%=pacsLink(dr["Modality"].ToString(),dr["urlview"].ToString()) %>" role="button"><i class="fa fa-picture-o" aria-hidden="true"></i></a></td>
                            </tr>
                            <% } %>
                        </tbody>
                        <tfoot class="mdb-color lighten-3 white-text">
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
                                <th>ผล</th>
                                <th>DCM</th>
                                <th>ดูภาพ</th>
                            </tr>
                        </tfoot>
                    </table>
                </ContentTemplate>

            </asp:UpdatePanel>
        </div>
    </div>
    <footer>
        <div align="center">
            <img src="../media/gd4_Small.png" width="50" height="38" />
        </div>
    </footer>


    <!-- Modal report -->
    <div id="mdReport" class="modal fade" role="dialog">

        <div class="modal-dialog modal-xl modal-full-height modal-top modal-notify  modal-warning">
            <input type="hidden" class="form-control-plaintext" name="stuid" id="stuid" value="" />
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <span class="navbar-brand mb-0">
                        <span class="text-center">
                            <i class="fa fa-pencil-square-o"></i>
                            ผลการอ่าน
                        </span></span>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="txtStuid" name="txtStuid" value="">
<%--                    <div id="bnCMD" align="right">
                        <div class="row d-flex justify-content-end bnCmd">
                            <div class="btn-group" data-toggle="buttons">

                                <label class="btn btn-danger">
                                    <input type="radio" name="options" class="rddoctor" id="rdAbNormal" value="false" autocomplete="off">
                                    ผิดปกติ                                     
                                </label>
                                <label class="btn btn-success">
                                    <input type="radio" name="options" class="rddoctor" id="rdNormal" value="true" autocomplete="off">
                                    ปกติ
                                </label>
                            </div>
                        </div>
                        <script>
                            $(".rddoctor").change(function () {
                                var selValue = $("input[type='radio']:checked").val();
                                // alert(selValue);
                                if (selValue == 'true') {
                                    if (confirm("ต้องการบันทึก ผลการตรวจ [ ปกติ ] ?")) {
                                        var content = tinyMCE.activeEditor.getContent();
                                        tinyMCE.activeEditor.setContent(content + ' ปกติ');
                                        content = tinyMCE.activeEditor.getContent();
                                        var stuid = $('#txtStuid').val();
                                        addreport(stuid, content, true);

                                    }
                                    else {
                                        return false;
                                    }
                                }
                            });
                        </script>
                    </div>--%>
                    <div class="form-row">
                        <div class="w-100 p-3" style="height: 500px;">
                            <textarea id="txtMemmo" name="mytextarea"> </textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="bnSave" class="btn btn-success" data-dismiss="modal">
                        บันทึกผล</button>
                    <script>
                        $("#bnSave").click(function () {

                            if (confirm("ยืนยันผลการตรวจ?")) {
                                var content = tinyMCE.activeEditor.getContent();
                                // tinyMCE.activeEditor.setContent(content + ' ปกติ');
                                content = tinyMCE.activeEditor.getContent();
                                var stuid = $('#txtStuid').val();
                               // var selValue = $("input[type='radio']:checked").val();
                                addreport(stuid, content, true);
                            }
                            else {
                                return false;
                            }
                        });
                    </script>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        ปิด</button>
                </div>
            </div>
        </div>

    </div>

    <!-- Modal Popup -->

    <script>
        $(function () {
            if (!jQuery.browser.msie) {
                alert('UNEO รองรับการใช้งานบน Microsoft Internet Explorer IE. เท่านั้น');
            }
        });
        function OpenPopupCenter(pageURL, title, w, h) {
            var left = (screen.width - w) / 2;
            var top = (screen.height - h) / 4;  // for 25% - devide by 4  |  for 33% - devide by 3
            var targetWin = window.open(pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
        }

        function addreport(stid, memo, normal) {
            var webMethod = "../service/report.asmx/addReport";
           
            var dataToSend = JSON.stringify({
                'comment': memo, 'stuid': stid, 'normal': normal, 'doctor': "<%= Session["fullname"].ToString() %>"
            });
            //alert(dataToSend);
            $.ajax({
                type: "POST",
                url: webMethod,
                data: dataToSend,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d = true) {
                        alert('บันทึกเรียบร้อย');
                        $(".modal:visible").modal('toggle');

                        $('#<%= bnFind.ClientID %>').trigger('click');
                    }
                },
                error: function (e) {
                    alert('error:' + e.responseText);
                }
            });
        }
        $(function () {
            tinymce.init({
                selector: '#txtMemmo',
                height: 480,
                encoding: 'xml',
                plugins: "print"
            });

            // Section Modal Report

            $("#mdReport").on('shown.bs.modal', function () {
                var txt = $('#stuid').val().split("|");

                var id = txt[0];
                var hn = txt[1];
                var name = txt[2];
                var desc = txt[3];
                var dt = txt[4];
                var tm = txt[5];
                $('#txtStuid').val(id);
                getreport(id);
            });

            function getreport(stuid) {
                var webMethod = "../service/report.asmx/getReport";
                //alert(webMethod);
                $.ajax({
                    type: "POST",
                    url: webMethod,
                    data: '{"stuid":"' + stuid + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var parsed = $.parseJSON(data.d);

                        tinyMCE.activeEditor.setContent('');
                        if (parsed.length > 0) {
                            $.each(parsed, function (i, jsondata) {
                                //alert(jsondata.StudyInstanceUid);
                                //$('#txtMemmo').val(jsondata.comment);
                                tinyMCE.activeEditor.remove();

                                tinymce.init({
                                    selector: '#txtMemmo',
                                    height: 480,
                                    encoding: 'xml',
                                    plugins: "print",
                                    statusbar: false,
                                    toolbar: false
                                    // menubar: false
                                });

                                tinyMCE.activeEditor.setContent(jsondata.comment);
                                //tinyMCE.activeEditor.setMode('readonly');
                                //tinyMCE.activeEditor.getBody().contenteditable = false
                                //tinyMCE.activeEditor.remove();
                                $('#bnCMD').hide();
                                $('#bnSave').hide();
                            });
                        } else {
                            $('#bnCMD').show();
                            $('#bnSave').show();

                            var txt = $('#stuid').val().split("|");

                            var id = txt[0];
                            var hn = txt[1];
                            var name = txt[2];
                            var desc = txt[3];
                            var dt = txt[4];
                            var tm = txt[5];

                            txt = '<table style="width: 100%;" border="0">';
                            txt += ' <tbody>';
                            txt += '<tr>';
                            txt += '<td style="width: 50%; text-align: center;" colspan="2" ><%= ins() %></td>';
                            txt += '</tr>';
                            txt += '    <tr> ';
                            txt += '         <td style="width: 50%;">HN:' + hn + '</td> ';
                            txt += '         <td style="width: 50%; text-align: justify;">ชื่อ-นามสกุล: ' + name + '</td>  ';
                            txt += '    </tr> ';
                            txt += '    <tr>  ';
                            txt += '        <td style="width: 50%;">รายการ : ' + desc + '</td> ';
                            txt += '         <td style="width: 50%; text-align: justify;">วันที่ทำ : ' + dt + ' ' + tm + '</td>';
                            txt += '    </tr>  ';
                            txt += '<tr><td style="width: 50%; text-align: right;" colspan="2" >อ่านผลโดย : <%= Session["fullname"] %></td>';
                            txt += '</tr>';
                            txt += '<tr><td style="width: 50%; text-align: right;" colspan="2" >ลงวันที่ : <%= formatDate(DateTime.Now.ToString("yyyyMMdd",uTH),true) + " " + DateTime.Now.ToString("HH:mm")%></td>';
                            txt += '</tr>';
                            txt += ' </tbody> ';
                            txt += '</table>';
                            txt += 'ผลการตรวจ :<br><br>';

                            tinyMCE.activeEditor.remove();
                            tinymce.init({
                                selector: '#txtMemmo',
                                height: 480,
                                encoding: 'xml',
                                plugins: "print"
                            });
                            tinyMCE.activeEditor.setMode('design');
                            tinyMCE.activeEditor.setContent(txt);


                        }
                    },
                    error: function (e) {
                        alert('error:' + e.responseText);
                    }
                });
            }

            // end section modal report

            $(document).on("click", ".bnrpt", function () {
                var myBookId = $(this).data('id');
                $("#stuid").val(myBookId);
            });

            var table = $("#tbStudy").DataTable(
                {
                    'responsive': true,
                    scrollY: '45vh',
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

        //On UpdatePanel Refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    var table = $("#tbStudy").DataTable(
                        {
                            'responsive': true,
                            scrollY: '45vh',
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
                    $('.input-daterange').datepicker({
                        language: 'th-th', format: 'dd/mm/yyyy', todayBtn: "linked",
                        todayHighlight: true
                    })
                    //$('.msMod').multiselect({
                    //    includeSelectAllOption: true
                    //});

<%--                    $(document).on("click", ".bnfind", function () {
                        var id = $("#<%= txtID.ClientID %>").val();
                        var name = $("#<%= txtName.ClientID %>").val();
                        var dt1 = $("#<%= txtDt1.ClientID %>").val();
                        var dt2 = $("#<%= txtDt2.ClientID %>").val();
                        var desc = $("#<%= txtDesc.ClientID %>").val();

                        if (id.length == 0 && name.length == 0 && dt1.length == 0 && dt2.length == 0 && desc.length == 0) {
                            //ConfirmDialog('กรุณายืนยันการค้นหาแบบไม่มีเงื่อนไข<br>ระบบจะประมวลผลช้า เนื่องจากแสดงรายการทั้งหมด');
                            if (confirm("ต้องการค้นหาแบบไม่มีเงื่อนไข?\nข้อมูลจะถูกแสดงทั้งหมด!! กรุณายืนยัน")) {
                                return true;
                            }
                            else {
                                return false;
                            }
                        }
                    });--%>
                }
            });
        }


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
        }
    </script>

</asp:Content>
