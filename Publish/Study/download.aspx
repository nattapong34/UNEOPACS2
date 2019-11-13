<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="UNEOPACS2.Study.download" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.4.1.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="card">
  <div class="card-header">
      <asp:Label ID="lbTitle" runat="server" Text="Title"></asp:Label>
  </div>
  <div class="card-body">
    <h5 class="card-title">Special title treatment</h5>
    <p class="card-text">
        <asp:Label ID="lbFile" runat="server" Text="lbFile"></asp:Label>
      </p>
      <br />
      <asp:Button ID="bnDownload" runat="server" OnClick="bnDownload_Click" Text="Download" />
  </div>
</div>
        </div>
    </form>
</body>
</html>
