<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/root" priority="1">
    <html xmlns="http://www.w3.org/1999/xhtml/">
      <body>
        <style>
          table {
          border-width: 1px;
          border-spacing: 1px;
          border-style: outset;
          border-color: gray;
          border-collapse: separate;
          background-color: white;
          align: center;
          }

          table td {
          border-width: 1px;
          padding: 1px;
          border-style: inset;
          border-color: gray;
          background-color: white;
          -moz-border-radius: ;
          }
        </style>
        <center>
          <h1>Devices list</h1>
          <table style="border:0px">
          <tr>
            <th>Device</th>
            <th>Host</th>
            <th>Service URL</th>
            <th>Duplicates</th>
          </tr>
          <xsl:for-each select="//nodes/device">
            <xsl:sort order ="ascending" select="data/name"/>
            <tr>
              <td>
                <b>
                  <a href="https://prtg.networks.local/device.htm?id={@id}" target="_new">
                    <xsl:value-of select="translate(data/name, ' ', '')"/>
                  </a>
                </b>
              </td>
              <td>
                <xsl:value-of select="translate(translate(data/host, '&#10;', ''), ' ', '')"/>
              </td>
              <td>
                <xsl:value-of select="translate(data/serviceurl, ' ', '')"/>
              </td>
              <td>
                <!--<xsl:for-each select="//nodes/device[contains(translate(data/name, ' ', ''), 'SRV115RADB01') and @id != current()/@id]">-->
                <xsl:for-each select="//nodes/device[contains(data/name, translate(translate(current()/data/host, '&#10;', ''), ' ', '')) and @id != current()/@id]">
                  <!--<xsl:for-each select="//nodes/device[contains(data/name, translate(current()/data/host, '\n', '')) and @id != current()/@id]">-->
                  <div>
                    <a href="https://prtg.networks.local/device.htm?id={@id}" target="_new">
                      <xsl:value-of select="data/name"/>
                    </a>
                  </div>
                </xsl:for-each>
                <!--
                <xsl:apply-templates select="//nodes/device[contains(translate(data/name, ' ', ''), translate(current()/data/host, ' ', '')) and @id != current()/@id]"/>-->
              </td>
            </tr>
          </xsl:for-each>
        </table>
        </center>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="device">
    <div>
      <xsl:value-of select="data/name"/>
    </div>
  </xsl:template>
</xsl:stylesheet>
