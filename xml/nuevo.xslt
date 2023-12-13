<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <html>
    <head>
      <style>
        table {
          border-collapse: collapse;
          width: 100%;
        }

        th, td {
          border: 1px solid #dddddd;
          text-align: left;
          padding: 8px;
        }

        th {
          background-color: #f2f2f2;
        }
      </style>
    </head>
    <body>
      <h2>Información CFDI</h2>
      <table>
        <tr>
          <th>Emisor</th>
          <th>Receptor</th>
        </tr>
        <xsl:for-each select="/Comprobante">
          <tr>
            <td>
              <strong>RFC:</strong>
              <xsl:value-of select="Emisor/@Rfc"/>
              <br/>
              <strong>Nombre:</strong>
              <xsl:value-of select="Emisor/@Nombre"/>
              <!-- Agrega más campos según sea necesario -->
            </td>
            <td>
              <strong>RFC:</strong>
              <xsl:value-of select="Receptor/@Rfc"/>
              <br/>
              <strong>Nombre:</strong>
              <xsl:value-of select="Receptor/@Nombre"/>
              <!-- Agrega más campos según sea necesario -->
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </body>
  </html>
</xsl:stylesheet>
