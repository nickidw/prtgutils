<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/root" priority="1">
      <devices>
      <xsl:for-each select="basenode/nodes/group[@id='0']/nodes/probenode">
          <xsl:sort order ="ascending" select="data/name"/>
          <xsl:for-each select="nodes/device | nodes/group/nodes/device">
            <xsl:sort order ="ascending" select="data/name"/>
            <xsl:if test="not(contains(data/name, 'Probe Device')) and not(contains(data/tags, 'vendors_Cisco')) and not(contains(data/tags, 'gateway')) and not(contains(data/tags, 'alienvault_interface')) and not(contains(data/tags, 'vmware_esx')) and not(contains(data/tags, 'waf_vip')) and not(contains(data/tags, 'remote_endpoint')) and not(contains(data/tags, 'ups')) and not(contains(data/tags, 'san_controller')) and not(contains(data/tags, 'server_secondip')) and not(contains(data/tags, 'network_device'))">
              <device>
                <name>
                  <xsl:value-of select="translate(translate(data/name, '&#10;', ''), ' ', '')"/>
                </name>
                <host>
                  <xsl:value-of select="translate(translate(data/host, '&#10;', ''), ' ', '')"/>
                </host>
              </device>
            </xsl:if>
          </xsl:for-each>
        </xsl:for-each>
      </devices>
  </xsl:template>

  <html xmlns="http://www.w3.org/1999/xhtml/">
    <body>
      <xsl:template match="basenode/nodes/group/nodes/probenode">
        <xsl:value-of select="data/name"/>
      </xsl:template>
    </body>
  </html>

</xsl:stylesheet>
