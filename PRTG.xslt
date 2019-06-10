﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
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
          <h1>Devices without at least 1 Disk, 1 CPU and 2 Memory sensors (SNMP)</h1>
          <table style="border:0px">
          <tr>
            <th>Device</th>
            <th>Memory<br/>Sensor<br/>count</th>
            <th>Disk<br/>sensor <br/>count</th>
            <th>CPU <br/>sensor<br/> count</th>
            <th>Uptime <br/>sensor<br/> count</th>
          </tr>
          <xsl:for-each select="basenode/nodes/group[@id='0']/nodes/probenode">
            <tr>
              <td colspan="5">
                <b>
                <xsl:value-of select="data/name"/>
                </b>
              </td>
            </tr>
              <xsl:for-each select="nodes/device">
                  <xsl:variable name="sensorcount"
                    select="count(nodes/sensor[contains(data/sensorkind,'snmpmemory')]) + count(nodes/sensor[contains(data/sensorkind,'snmpdiskfree')]) + count(nodes/sensor[contains(data/sensorkind,'snmpcpu')]) + count(nodes/sensor[contains(data/sensorkind,'snmpuptime')])"/>
                  <xsl:if test="not(contains(data/name, 'Probe Device')) and not(contains(data/name, 'PRTG')) and not($sensorcount >= 4) and not(contains(data/tags, 'vendors_Cisco')) and not(contains(data/tags, 'gateway')) and not(contains(data/tags, 'alienvault_interface')) and not(contains(data/tags, 'vmware_esx'))">
                    <tr>
                      <td><xsl:value-of select="data/name"/>
                      <!--<xsl:value-of select="$sensorcount"/>-->
                    </td>
                  <td><xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpmemory')])"/></td>
                  <td>
                    <xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpdiskfree')])"/>
                  </td>
                  <td>
                    <xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpcpu')])"/>
                  </td>
                  <td>
                    <xsl:value-of select="count(nodes/sensor[contains(data/sensorkind,'snmpuptime')])"/>
                  </td>
                  <!--          <xsl:for-each select="nodes/sensor">
              <xsl:value-of select="data/sensorkind"/>
            </xsl:for-each>-->
                    </tr>
                  </xsl:if>
                </xsl:for-each>
          </xsl:for-each>
        </table>
        </center>
      </body>
    </html>
  </xsl:template>

  <html xmlns="http://www.w3.org/1999/xhtml/">
    <body>
      <xsl:template match="basenode/nodes/group/nodes/probenode">
        <xsl:value-of select="data/name"/>
      </xsl:template>
    </body>
  </html>

</xsl:stylesheet>