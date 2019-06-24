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
          font-family: Verdana;
          font-size:12;
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
              <th>
                Lab<br/>Server
              </th>
              <th>Host</th>
              <th>Service URL</th>
              <th>Duplicates</th>
            </tr>
            <xsl:for-each select="basenode/nodes/group[@id='0']/nodes/probenode">
              <xsl:sort order ="ascending" select="data/name"/>
              <tr>
                <td colspan="5">
                  <b>
                    <xsl:value-of select="data/name"/>
                  </b>
                </td>
              </tr>
              <xsl:for-each select="nodes/device | nodes/group/nodes/device">
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
                    <xsl:if test="contains(data/tags, 'Lab_Server')">
                      X
                    </xsl:if>
                  </td>              
                  <td>
                    <xsl:value-of select="translate(translate(data/host, '&#10;', ''), ' ', '')"/>
                  </td>
                  <td>
                    <xsl:value-of select="translate(data/serviceurl, ' ', '')"/>
                  </td>
                  <td>
                    <xsl:for-each select="//nodes/device[not(contains(data/name, 'Probe Device')) and (contains(data/name, concat(translate(translate(current()/data/host, '&#10;', ''), ' ', ''), '.')) or translate(translate(data/name, '&#10;', ''), ' ', '') = translate(translate(current()/data/host, '&#10;', ''), ' ', '') or translate(translate(data/host, '&#10;', ''), ' ', '') = translate(translate(current()/data/host, '&#10;', ''), ' ', '')) and @id != current()/@id and not(contains(data/tags, 'Server_SecondIP')) and not(contains(current()/data/tags, 'Server_SecondIP'))]">
                      <div>
                        <a href="https://prtg.networks.local/device.htm?id={@id}" target="_new">
                          <xsl:value-of select="data/name"/>
                        </a>
                      </div>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
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
