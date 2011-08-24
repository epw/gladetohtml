<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:g2h="http://users.wpi.edu/~epw/gladetohtml"
  xmlns="http://www.w3.org/1999/xhtml">
 
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

  <xsl:key name="ref" match="object" use="@id" />

  <xsl:template match="/">
    <html lang="en">
      <head>
	<title><xsl:choose><xsl:when test="/interface/object[@class='GtkWindow']/property[@name='title']"><xsl:value-of select="/interface/object[@class='GtkWindow']/property[@name='title']" /></xsl:when><xsl:otherwise><g2h:extern>TITLE</g2h:extern></xsl:otherwise></xsl:choose></title>
	<link rel="stylesheet" href="\$extern[GTKCSS]" />
	<link rel="stylesheet" href="\$extern[BASENAME].css" />
	<xsl:if test="/interface/object[@class='GtkWindow']/property[@name='icon']"><link rel="icon" href="{/interface/object[@class='GtkWindow']/property[@name='icon']}" type="image/x-icon" /><link rel="shortcut icon" href="{/interface/object[@class='GtkWindow']/property[@name='icon']}" type="image/x-icon" /></xsl:if>
	<style type="text/css">
#<xsl:value-of select="/interface/object[@class='GtkWindow']/@id" /> { <xsl:apply-templates select="/interface/object[@class='GtkWindow']/property" />}
	  <xsl:for-each select="//child">
#container_<xsl:value-of select="object/@id" /> { <xsl:apply-templates select="object/property | packing/property"><xsl:with-param name="type" select="'container'" /></xsl:apply-templates><xsl:call-template name="negated"><xsl:with-param name="type" select="'container'" /></xsl:call-template>}
#<xsl:value-of select="object/@id" /> { <xsl:apply-templates select="object/property | packing/property" /><xsl:call-template name="negated" />}
</xsl:for-each>
	</style>
	<script type="text/javascript" src="\$extern[JQUERY]">/* */</script>
	<script type="text/javascript" src="\$extern[WEBSHIMS]">/* */</script>
	<script type="text/javascript" src="\$extern[BASENAME].js">/* */</script>
	<script type="text/javascript">
function glade_init () {
	  <xsl:for-each select="/interface/object[@class='GtkWindow']//object[signal]">
  try {
<xsl:apply-templates select="signal" />
  } catch (err) {
    if (err.name != "ReferenceError") {
      throw (err);
    }
  }
</xsl:for-each>

	  <xsl:for-each select="/interface/object[@class='GtkWindow']//object">
<xsl:call-template name="scripts" />
</xsl:for-each>

}
$(document).ready (glade_init);
</script>
      </head>
      <body>
        <xsl:apply-templates select="/interface/object[@class='GtkWindow']" />
      </body>
    </html>
  </xsl:template>

  <!-- CSS -->

  <!-- Default case, do nothing -->
  <xsl:template match="property"></xsl:template>

  <xsl:template match="property[@name = 'default_width']">width: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'width_request']">min-width: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'default_height']">height: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'height_request']">min-height: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'visible']"><xsl:param name="type" /><xsl:if test="$type = 'container' and self::node() = 'False'">display: none; </xsl:if></xsl:template>

  <xsl:template match="property[@name = 'expand']"><xsl:if test="self::node() = 'True'">width: 100%; </xsl:if></xsl:template>

  <xsl:template match="property[@name = 'xpad']">padding-left: <xsl:value-of select="." />px; padding-right: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'ypad']">padding-top: <xsl:value-of select="." />px; padding-bottom: <xsl:value-of select="." />px; </xsl:template>

  <xsl:template match="property[@name = 'single_line_mode']"><xsl:if test="self::node() = 'True'">text-wrap: none; </xsl:if></xsl:template> 

  <xsl:template match="property[@name = 'has_frame']"><xsl:if test="self::node() = 'False'">border: none; </xsl:if></xsl:template> 

  <!-- Template for unusual properties that cannot be tested for normally -->
  <xsl:template name="negated">
    <xsl:param name="type" />
    <xsl:if test="not(object/property[@name='visible'] = 'True')">display: none; </xsl:if>
    <xsl:if test="not($type = 'container') and not(packing/property[@name='expand'] = 'False')">width: 100%; </xsl:if>
    <xsl:if test="$type = 'container' and not(packing/property[@name='fill'] = 'False')">box-flex: 1.0; -webkit-box-flex: 1.0; -moz-box-flex: 1.0; </xsl:if>
  </xsl:template>

  <!-- JavaScript -->

  <!-- Default case, do nothing -->
  <xsl:template match="signal"></xsl:template>

  <xsl:template match="signal[@name='clicked']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('click', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='enter']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mouseover', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='leave']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mouseout', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='pressed']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mousedown', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='released']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mouseup', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='button-press-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mousedown', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='button-release-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('mouseup', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='focus']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('focus', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='focus-in-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('focus', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='focus-out-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('blur', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='key-press-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('keypress', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='key-release-event']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('keyup', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='insert-text']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('change', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='delete-text']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('change', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <xsl:template match="signal[@name='changed']">
    document.getElementById ('<xsl:value-of select="../@id" />').addEventListener ('change', <xsl:value-of select="@handler" />, false);
  </xsl:template>

  <!-- Template for unusual properties that cannot be tested for normally -->
  <xsl:template name="scripts">
<xsl:if test="@class = 'GtkLinkButton'">  document.getElementById ('<xsl:value-of select="@id" />').addEventListener ('click', function () { window.location.href = '<xsl:value-of select="property[@name='uri']" />'; }, false);
</xsl:if>
<xsl:if test="@class = 'GtkHScale' or @class = 'GtkVScale'">  document.getElementById ('<xsl:value-of select="@id" />').addEventListener ("change", function () { document.getElementById ('span_<xsl:value-of select="@id" />').innerHTML = document.getElementById('<xsl:value-of select="@id" />').value; }, false);
</xsl:if>
  </xsl:template>

  <!-- Entire window -->

  <xsl:template match="object[@class='GtkWindow']">
    <div class="GtkWindow" id="{@id}">
      <xsl:apply-templates select="child/object" />
    </div>
  </xsl:template>

  <!-- Containers -->

  <xsl:template match="object[@class='GtkVBox']">
    <div class="GtkVBox" id="{@id}">
      <xsl:apply-templates select="child/object" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkHBox']">
    <div class="GtkHBox" id="{@id}">
      <xsl:apply-templates select="child/object" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkVButtonBox']">
    <div class="GtkVButtonBox" id="{@id}">
      <xsl:apply-templates select="child/object" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkHButtonBox']">
    <div class="GtkHButtonBox" id="{@id}">
      <xsl:apply-templates select="child/object" />
    </div>
  </xsl:template>

  <!-- General elements -->

  <xsl:template match="object[@class='GtkLabel']">
    <div class="GtkLabelContainer" id="container_{@id}">
      <span class="GtkLabel" id="{@id}">
	<xsl:value-of select="property[@name='label']" />
      </span>
    </div>
  </xsl:template>

  <!-- Input elements -->

  <xsl:template match="object[@class='GtkButton']">
    <div class="GtkButtonContainer" id="container_{@id}">
      <input type="button" class="GtkButton" name="{@id}" id="{@id}"
	     value="{property[@name='label']}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkEntry']">
    <xsl:variable name="type"><xsl:choose>
	<xsl:when test="property[@name='visibility'] = 'False'">password</xsl:when>
	<xsl:otherwise>text</xsl:otherwise>
    </xsl:choose></xsl:variable>
    <div class="GtkEntryContainer" id="container_{@id}">
      <xsl:choose>
	<xsl:when test="property[@name='editable'] = 'False'"><input type="{$type}" class="GtkEntry" name="{@id}" id="{@id}" disabled="disabled" value="{property[@name='text']}" /></xsl:when>
	<xsl:otherwise><input type="{$type}" class="GtkEntry" name="{@id}" id="{@id}" value="{property[@name='text']}" /></xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkToggleButton']">
    <div class="GtkToggleButtonContainer" id="container_{@id}">
      <input type="button" class="GtkToggleButton" name="{@id}" id="{@id}"
	     value="{property[@name='label']}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkCheckButton']">
    <div class="GtkCheckButtonContainer" id="container_{@id}">
      <span class="GtkCheckButton" id="{@id}">
	<input type="checkbox" class="GtkCheckButton" name="{@id}" id="input_{@id}" />
	<label for="input_{@id}"><xsl:value-of select="property[@name='label']" /></label>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkRadioButton']">
    <xsl:variable name="name"><xsl:choose>
	<xsl:when test="property[@name='group']"><xsl:value-of select="property[@name='group']" /></xsl:when>
	<xsl:otherwise><xsl:value-of select="@id" /></xsl:otherwise>
    </xsl:choose></xsl:variable>
    <div class="GtkRadioButtonContainer" id="container_{@id}">
      <span class="GtkRadioButton" id="{@id}">
	<input type="radio" class="GtkRadioButton" name="$name" id="input_{@id}" />
	<label for="input_{@id}"><xsl:value-of select="property[@name='label']" /></label>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkFileChooserButton']">
    <div class="GtkFileChooserButtonContainer" id="container_{@id}">
      <input type="file" class="GtkFileChooserButton" name="{@id}" id="{@id}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkColorButton']">
    <div class="GtkColorButtonContainer" id="container_{@id}">
      <input type="color" class="GtkColorButton" name="{@id}" id="{@id}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkLinkButton']">
    <div class="GtkLinkButtonContainer" id="container_{@id}">
      <input type="button" class="GtkLinkButton" name="{@id}" id="{@id}" value="{property[@name='label']}"/>
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkImage']">
    <div class="GtkImageContainer" id="container_{@id}">
      <img class="GtkImage" id="{@id}" src="{property[@name='pixbuf']}" width="{property[@name='width_request']}" height="{property[@name='height_request']}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkHScale']">
    <xsl:variable name="adjustment"><xsl:value-of select="property[@name='adjustment']" /></xsl:variable>
    <div class="GtkHScaleContainer" id="container_{@id}">
      <span class="GtkHScale" id="span_{@id}"><xsl:value-of select="key ('ref', $adjustment)/property[@name='value']" /></span><br />
      <input type="range" class="GtkHScale" name="{@id}" id="{@id}" min="{key ('ref', $adjustment)/property[@name='lower']}" max="{key ('ref', $adjustment)/property[@name='upper']}" step="{key ('ref', $adjustment)/property[@name='step_increment']}" value="{key ('ref', $adjustment)/property[@name='value']}" />
    </div>
  </xsl:template>

  <xsl:template match="object[@class='GtkVScale']">
    <xsl:variable name="adjustment"><xsl:value-of select="property[@name='adjustment']" /></xsl:variable>
    <div class="GtkVScaleContainer" id="container_{@id}">
      <span class="GtkVScale" id="span_{@id}"><xsl:value-of select="key ('ref', $adjustment)/property[@name='value']" /></span><br />
      <input type="range" class="GtkVScale" name="{@id}" id="{@id}" min="{key ('ref', $adjustment)/property[@name='lower']}" max="{key ('ref', $adjustment)/property[@name='upper']}" step="{key ('ref', $adjustment)/property[@name='step_increment']}" value="{key ('ref', $adjustment)/property[@name='value']}" />
    </div>
  </xsl:template>
  

</xsl:stylesheet>
