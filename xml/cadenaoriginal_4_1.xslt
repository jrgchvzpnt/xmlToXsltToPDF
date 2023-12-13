<?xml version=""1.0"" encoding=""UTF-8""?>
<xsl:stylesheet xmlns:xsl=""http://www.w3.org/1999/XSL/Transform"" version=""1.0"">
  <xsl:output method=""html"" encoding=""UTF-8""/>

  <xsl:template match=""/"">
    <html>
      <head>
        <title>Resultado XML a HTML</title>
      </head>
      <body>
        <table border=""1"">
          <tr>
            <th>Rfc Emisor</th>
            <th>Nombre Emisor</th>
            <th>Regimen Fiscal Emisor</th>
            <th>Rfc Receptor</th>
            <th>Nombre Receptor</th>
            <th>Domicilio Fiscal Receptor</th>
            <th>Regimen Fiscal Receptor</th>
            <th>Uso CFDI</th>
            <th>Clave Prod Serv</th>
            <th>Cantidad</th>
            <th>Clave Unidad</th>
            <th>Unidad</th>
            <th>Descripcion</th>
            <th>Valor Unitario</th>
            <th>Descuento</th>
            <th>Importe</th>
            <th>Base Traslado</th>
            <th>Importe Traslado</th>
            <th>Impuesto Traslado</th>
            <th>TasaOCuota Traslado</th>
            <th>TipoFactor Traslado</th>
          </tr>
          <xsl:apply-templates select=""//cfdi:Comprobante/cfdi:Emisor | //cfdi:Comprobante/cfdi:Receptor | //cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto | //cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado""/>
        </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match=""cfdi:Emisor | cfdi:Receptor"">
    <tr>
      <td><xsl:value-of select=""@Rfc""/></td>
      <td><xsl:value-of select=""@Nombre""/></td>
      <td><xsl:value-of select=""@RegimenFiscal""/></td>
      <!-- Añadir más campos según sea necesario -->
    </tr>
  </xsl:template>

  <xsl:template match=""cfdi:Concepto"">
    <tr>
      <td></td> <!-- Rellenar con espacios ya que no hay información del Emisor/Receptor aquí -->
      <!-- Añadir más campos según sea necesario -->
    </tr>
  </xsl:template>

  <xsl:template match=""cfdi:Traslado"">
    <tr>
      <td></td> <!-- Rellenar con espacios ya que no hay información del Emisor/Receptor aquí -->
      <td></td> <!-- Rellenar con espacios ya que no hay información del Concepto aquí -->
      <!-- Añadir más campos según sea necesario -->
    </tr>
  </xsl:template>
</xsl:stylesheet>