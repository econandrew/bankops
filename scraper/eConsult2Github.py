import lxml.etree as ET
import requests

url = "https://wbgeconsult2.worldbank.org/wbgect/gwproxy"
request_list = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Body>
    <GetCurrentPublicNotifications xmlns="http://cordys.com/WBGEC/DBT_Selection_Notification/1.0">
        <NotifTypeId3 xmlns="undefined">3</NotifTypeId3>
        <DS type="dsort"><selection_notification.eoi_deadline order="asc"></selection_notification.eoi_deadline></DS>
    </GetCurrentPublicNotifications>
    </soapenv:Body>
</soapenv:Envelope>"""
request_item = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Body>
    <GetNotificationDetailsBPM xmlns="http://cordys.com/WBGEC/BPM_Notification/1.0">
        <NotificationID xmlns="http://cordys.com/WBGEC/bpm/GetNotificationDetailsBPM">{id}</NotificationID>
    </GetNotificationDetailsBPM></soapenv:Body></soapenv:Envelope>"""

xslt_simplify = ET.parse('scraper/simplify.xsl')
simplifier = ET.XSLT(xslt_simplify)
xslt_yaml = ET.parse('scraper/xml2yaml.xsl')
yamler = ET.XSLT(xslt_yaml)

r = requests.post(url, request_list)

list_tree = ET.fromstring(r.content)
for elid in list_tree.findall('.//{http://cordys.com/WBGEC/DBT_Selection_Notification/1.0}SELECTION_NOTIFICATION/{http://cordys.com/WBGEC/DBT_Selection_Notification/1.0}ID'):
    print("Processing notification {}".format(elid.text))
    r = requests.post(url, request_item.format(id=elid.text))

    tree = ET.fromstring(r.content)
    simple_tree = simplifier(tree)
    elselid = simple_tree.find('./{http://cordys.com/WBGEC/DBT_Selection_Notification/1.0}SELECTION_NOTIFICATION/{http://cordys.com/WBGEC/DBT_Selection_Notification/1.0}SELECTION_ID')
    simple_tree.write("data/{}.xml".format(elselid.text))
    yaml_tree = yamler(simple_tree)

    with open("jekyll/notifications/{}.md".format(elselid.text), "w") as f:
        f.write(str(yaml_tree))