import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;

/**
 * Class to test the XSLT.
 * The first parameter is the IIA xml file name, the second is the xlst stylesheet file name.
 * They both must be in the directory from where you invoke this class
 * 
 * @author Francesco De Milato
 */
public class XsltTest
{
  public XsltTest (){}
  
  public static void main(String args[]) throws Exception
  {
    XsltTest xml = new XsltTest();
    System.setProperty( 
"javax.xml.transform.TransformerFactory","net.sf.saxon.TransformerFactoryImpl");

    if (args.length!=2) System.out.println("ERROR!\nSintax: java it.unige.ewp.tools.XmlTest <iiaFileName> <xsltFileName>");
    else
    {
      String iiaFileName = args[0];
      String xsltFileName = args[1];
      
      Path xsltPath = Paths.get(xsltFileName);
      Path iiaPath = Paths.get(iiaFileName);

      byte[] xsltData = Files.readAllBytes(xsltPath);
      byte[] iiaData = Files.readAllBytes(iiaPath);
      
      System.out.println("\n\nXSLT Result: \n"+xml.getXmlTransformed(iiaData, xsltData));
      System.out.println("\n\nBe careful to use the right xslt for your IIA Version!");
      System.out.println("Now you can get the element text-to-hash and compute its SHA-256 hash code\n\n");
    }
  }
  
  /**
   * Transform an xml file by means of an xslt file
   * 
   * @param xmlBytes The content of the xml file
   * @param xsltBytes The content of the xslt file
   * @return An xml useful to compute the hash code
   * @throws Exception 
   */
  public String getXmlTransformed(byte xmlBytes[], byte xsltBytes[]) throws Exception
  {
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
    dbf.setNamespaceAware(true);
      
    DocumentBuilder db = dbf.newDocumentBuilder();
    Document document = db.parse(new ByteArrayInputStream(xmlBytes)); 
    
    TransformerFactory transformerFactory = TransformerFactory.newInstance();
    Transformer transformer = transformerFactory.newTransformer(
                                                    new StreamSource(new ByteArrayInputStream(xsltBytes)));
    ByteArrayOutputStream output = new ByteArrayOutputStream();
     
    transformer.transform(new DOMSource(document), new StreamResult(output));
     
    return new String( output.toByteArray());
  }  
}

