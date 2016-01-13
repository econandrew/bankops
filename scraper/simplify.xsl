<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns:WB="http://cordys.com/WBGEC/BPM_Notification/1.0" xmlns:WBN="http://cordys.com/WBGEC/DBT_Selection_Notification/1.0" xmlns:WBC="http://cordys.com/WBGEC/DBT_Selection_Country/1.0" xmlns:WBTF="http://cordys.com/WBGEC/DBT_Selection_Trust_Fund/1.0" xmlns:WBNA="http://cordys.com/WBGEC/DBT_Notification_Attachment/1.0" xmlns:WBQC="http://cordys.com/WBGEC/DBT_Notification_Qual_Crit/1.0">
<xsl:output method="xml" indent="yes"/>
    
<xsl:template match="/">
<xsl:apply-templates select="SOAP:Envelope/SOAP:Body/WB:GetNotificationDetailsBPMResponse"/>
</xsl:template>

<xsl:template match="WB:GetNotificationDetailsBPMResponse">
<NOTIFICATION>
    <xsl:apply-templates select="WBN:GetNotificationByNotificationIDResponse/*/*/*"/>
    <SELECTION_COUNTRY>
        <xsl:apply-templates select="WBC:GetCountriesBySelectionIDResponse/*/*/*" mode="list"/>
    </SELECTION_COUNTRY>
    <SELECTION_TRUST_FUND>
        <xsl:apply-templates select="WBTF:GetTrustFundsForSelectionResponse/*/*/*" mode="list"/>
    </SELECTION_TRUST_FUND>
    <NOTIFICATION_ATTACHMENT>
        <xsl:apply-templates select="WBNA:GetNotificationAttachmentsByNotificationIDResponse/*/*/*" mode="list"/>
    </NOTIFICATION_ATTACHMENT>
    <NOTIFICATION_QUAL_CRIT>
        <xsl:apply-templates select="WBQC:GetQualCriteriaForNotificationResponse/*/*/*" mode="list"/>    
    </NOTIFICATION_QUAL_CRIT>
</NOTIFICATION>
</xsl:template>

<xsl:template match="node()" mode="list">
<_>
    <xsl:copy-of select="@*" />
    <xsl:apply-templates select="node()[not(@null='true')]"/>
</_>
</xsl:template>

<xsl:template match="node()">
<xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:apply-templates select="node()[not(@null='true')]"/>
</xsl:copy>
</xsl:template>

<!-- this is a computed field that causes spurious diffs, so we suppress it -->
<xsl:template match="WBN:BEFORE_EOI_DEADLINE">
</xsl:template>

</xsl:stylesheet>