using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;

namespace xmlToXslt
{
    internal class Program
    {
        static void Main(string[] args)
        {
            CrearPdf();
        }

      
        public static void CrearPdf()
        {
            try
            {
                // Rutas de los archivos XML y XSLT
                string xmlFilePath = "C:\\Proyectos\\GenerateCFDI\\CFDI.xml";
                string xsltFilePath = "C:\\Proyectos\\GenerateCFDI\\CFDI.xslt";

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(xmlFilePath);

                XslCompiledTransform xslt = new XslCompiledTransform();
                xslt.Load(xsltFilePath);

                // Crear el archivo PDF
                using (MemoryStream pdfStream = new MemoryStream())
                {
                    using (StringWriter stringWriter = new StringWriter())
                    {
                        using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter, xslt.OutputSettings))
                        {
                            // Transformar el XML con el XSLT y escribir el resultado en el StringWriter
                            xslt.Transform(xmlDoc, xmlWriter);

                            // Convertir el resultado transformado a un string
                            string transformedXml = stringWriter.ToString();

                            // Crear el archivo PDF con el contenido transformado
                            PdfWriter pdfWriter = new PdfWriter(pdfStream);
                            PdfDocument pdfDocument = new PdfDocument(pdfWriter);
                            Document doc = new Document(pdfDocument);


                            string nombreEmisor = ObtenerAtributo("Emisor", "Nombre", xmlDoc);
                            doc.Add(new Paragraph($"Nombre: {nombreEmisor}"));
                            string rfcEmisor = ObtenerAtributo("Emisor", "Rfc", xmlDoc);
                            doc.Add(new Paragraph($"RFC: {rfcEmisor}"));



                            doc.Add(new Paragraph("Contenido Transformado:"));
                            doc.Add(new Paragraph(transformedXml));

                            // Guardar el documento PDF en un archivo
                            string pdfOutputPath = "C:\\Proyectos\\GenerateCFDI\\ruta_del_archivo.pdf";
                            pdfDocument.Close();
                            File.WriteAllBytes(pdfOutputPath, pdfStream.ToArray());

                            Console.WriteLine("Factura PDF generada exitosamente.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        private static string ObtenerAtributo(string nombreNodo, string nombreAtributo, XmlDocument xmlDoc)
        {
            // Crear un administrador de espacios de nombres para resolver el prefijo
            XmlNamespaceManager nsManager = new XmlNamespaceManager(xmlDoc.NameTable);
            nsManager.AddNamespace("cfdi", "http://www.sat.gob.mx/cfd/4");

            // Buscar el nodo con el nombre proporcionado y el espacio de nombres
            XmlNode nodo = xmlDoc.SelectSingleNode($"//cfdi:{nombreNodo}", nsManager);

            // Verificar si se encontró el nodo y si tiene el atributo deseado
            if (nodo != null && nodo.Attributes != null)
            {
                XmlAttribute atributo = nodo.Attributes[nombreAtributo];
                return atributo != null ? atributo.Value : string.Empty;
            }

            // Si no se encontró el nodo o el atributo, devolver una cadena vacía
            return string.Empty;
        }
    }
}
