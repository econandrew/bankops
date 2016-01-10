<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns:WB="http://cordys.com/WBGEC/BPM_Notification/1.0" xmlns:WBN="http://cordys.com/WBGEC/DBT_Selection_Notification/1.0" xmlns:WBC="http://cordys.com/WBGEC/DBT_Selection_Country/1.0" xmlns:WBTF="http://cordys.com/WBGEC/DBT_Selection_Trust_Fund/1.0" xmlns:WBNA="http://cordys.com/WBGEC/DBT_Notification_Attachment/1.0" xmlns:WBQC="http://cordys.com/WBGEC/DBT_Notification_Qual_Crit/1.0">

<xsl:template match="/">
    <NOTIFICATION>
    <xsl:copy-of select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse/WBN:GetNotificationByNotificationIDResponse/WBN:tuple/WBN:old/node()">
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy-of>
    <SELECTION_COUNTRY>
    <xsl:copy-of select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse/WBC:GetCountriesBySelectionIDResponse/WBC:tuple/WBC:old/node()"/>
    </SELECTION_COUNTRY>
    <SELECTION_TRUST_FUND>
    <xsl:copy-of select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse/WBTF:GetTrustFundsForSelectionResponse/WBTF:tuple/WBTF:old/node()"/>
    </SELECTION_TRUST_FUND>
    <NOTIFICATION_ATTACHMENT>
    <xsl:copy-of select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse/WBNA:GetNotificationAttachmentsByNotificationIDResponse/WBNA:tuple/WBNA:old/node()"/>
    </NOTIFICATION_ATTACHMENT>
    <NOTIFICATION_QUAL_CRIT>
    <xsl:copy-of select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse/WBQC:GetQualCriteriaForNotificationResponse/WBQC:tuple/WBQC:old/node()"/>    
    </NOTIFICATION_QUAL_CRIT>
    </NOTIFICATION>
</xsl:template>

<xsl:template match=
   "*[not(@*|*|comment()|processing-instruction()) 
    and normalize-space()=''
     ]"/>
</xsl:stylesheet>