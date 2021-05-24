<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<xsl:output method="text" omit-xml-declaration="yes" />
<xsl:template match="/root" priority="1">Device,Host,Memory Sensor count,Disk sensor count,CPU sensor count,Uptime sensor count
<xsl:for-each select="basenode/nodes/group[@id='0']/nodes/probenode">
  <xsl:sort order ="ascending" select="data/name"/>
  <xsl:for-each select="nodes/device | nodes/group/nodes/device">
    <xsl:sort order ="ascending" select="data/name"/>
    <xsl:variable name="memorysensorcount"
        select="count(nodes/sensor[contains(data/sensorkind,'snmpmemory')]) + count(nodes/sensor[contains(data/sensorkind,'wmimemory')]) + count(nodes/sensor[contains(data/sensorkind,'sshmeminfo')])"/>
    <xsl:variable name="disksensorcount"
        select="count(nodes/sensor[contains(data/sensorkind,'snmpdiskfree')]) + count(nodes/sensor[contains(data/sensorkind,'wmidiskspace')]) + count(nodes/sensor[contains(data/sensorkind,'sshdiskfree')])"/>
    <xsl:variable name="cpusensorcount"
        select="count(nodes/sensor[contains(data/sensorkind,'snmpcpu')]) + count(nodes/sensor[contains(data/sensorkind,'wmiprocessor')]) + count(nodes/sensor[contains(data/sensorkind,'sshloadavg')]) + count(nodes/sensor[contains(data/sensorkind,'snmplinuxloadavg')])"/>
    <xsl:variable name="uptimesensorcount"
        select="count(nodes/sensor[contains(data/sensorkind,'snmpuptime')]) + count(nodes/sensor[contains(data/sensorkind,'wmiuptime')]) + count(nodes/sensor[contains(data/sensorkind,'snmpciscosystemhealth')])"/>
    <xsl:if test="not(contains(data/name, 'Probe Device')) and not(contains(data/name, 'PRTG')) and (not($memorysensorcount >= 1) or not($disksensorcount >= 1) or not($cpusensorcount >= 1) or not($uptimesensorcount >= 1)) and not(contains(data/tags, 'vendors_Cisco')) and not(contains(data/tags, 'gateway')) and not(contains(data/tags, 'alienvault_interface')) and not(contains(data/tags, 'vmware_esx')) and not(contains(data/tags, 'waf_vip')) and not(contains(data/tags, 'remote_endpoint')) and not(contains(data/tags, 'ups')) and not(contains(data/tags, 'san_controller')) and not(contains(data/tags, 'Server_SecondIP')) and not(contains(data/tags, 'Network_device'))">
<xsl:value-of select="normalize-space(data/name)"/>,<xsl:value-of select="normalize-space(data/host)"/>,<xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpmemory')]) + count(nodes/sensor[contains(data/sensorkind,'wmimemory')]) + count(nodes/sensor[contains(data/sensorkind,'sshmeminfo')])"/>,<xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpdiskfree')]) + count(nodes/sensor[contains(data/sensorkind,'wmidiskspace')]) + count(nodes/sensor[contains(data/sensorkind,'sshdiskfree')])"/>,<xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpcpu')]) + count(nodes/sensor[contains(data/sensorkind,'wmiprocessor')]) + count(nodes/sensor[contains(data/sensorkind,'snmplinuxloadavg')]) + count(nodes/sensor[contains(data/sensorkind,'sshloadavg')])"/>,<xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpuptime')]) + count(nodes/sensor[contains(data/sensorkind,'wmiuptime')])"/>
        <xsl:text>&#10;</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <html xmlns="http://www.w3.org/1999/xhtml/">
    <body>
      <xsl:template match="basenode/nodes/group/nodes/probenode">
        <xsl:value-of select="data/name"/>
      </xsl:template>
    </body>
  </html>

</xsl:stylesheet>
