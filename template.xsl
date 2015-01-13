<?xml version="1.0" encoding="UTF-8"?>
<!--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

-->
<!--
    TODO: Describe this XSL file    
    Author: Alexey Maslov
    
-->    

<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
	xmlns:dri="http://di.tamu.edu/DRI/1.0/"
	xmlns:mets="http://www.loc.gov/METS/"
	xmlns:xlink="http://www.w3.org/TR/xlink/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
	xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:mods="http://www.loc.gov/mods/v3"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="i18n dri mets xlink xsl dim xhtml mods dc">
    
    <xsl:import href="../dri2xhtml.xsl"/>
    <xsl:output indent="yes"/>
	
    <xsl:template name="buildHeader">
		<div class='navbar navbar-static-top navbar-user-panel'>
		<div class='navbar-inner'>
		<div class='container'>
		<div class='gray-logo pull-left'>
		<a href="/"><img alt="Gray-logo" src="http://liot.mipt.ru/assets/mipt_liot/images/gray-logo.png" />
		</a></div>
		<ul class='tabs-menu nav nav-pills pull-left'>
		<li class='active'><a href="http://liot.mipt.ru">ИКП ЛИОТ</a></li>
		<li><a href="http://work.liot.mipt.ru">Управление задачами</a></li>
		<li><a href="http://dms.lectoriy.mipt.ru">Лекторий.DMS</a></li>
		</ul>
		<div class='user-menu pull-right'>
		<ul class="nav context-menu nav nav-pills"><li class="sign-up" id="sign_up"><a href="/users/sign_up">Зарегистрироваться</a></li><li class="sign-in" id="sign_in"><a href="/users/sign_in">Войти</a></li></ul>
		</div>
		</div>
		</div>
		</div>
		
		
		<div class='header-banner-container'>
		<div class='container'>
		<h1 class='brand'>
		<a href="/"><img alt="Logo" src="http://liot.mipt.ru/assets/mipt_liot/images/logo.png" />
		</a></h1>
		<div class='slogan pull-left'>
		Лаборатория инновационных образовательных технологий
		</div>
		<form accept-charset="UTF-8" action="/search" class="navbar-form pull-right" method="get">
		<div class='input-append pull-right'>
		<input class="input-sidebar" id="search" name="q" placeholder="поиск" type="text" />
		<button class="btn icon-search" type="submit"></button></div>
		</form>


		</div>
		</div>
		
        <div id="ds-header-wrapper">
            <div id="ds-header" class="clearfix">
                <a id="ds-header-logo-link">
                    <xsl:attribute name="href">
                        <xsl:value-of
                                select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath'][not(@qualifier)]"/>
                        <xsl:text>/</xsl:text>
                    </xsl:attribute>
                    <span id="ds-header-logo">&#160;</span>
                    <span id="ds-header-logo-text">
                       <i18n:text>xmlui.dri2xhtml.structural.head-subtitle</i18n:text>
                    </span>
                </a>
                <h1 class="pagetitle visuallyhidden">
                    <xsl:choose>
                        <!-- protection against an empty page title -->
                        <xsl:when test="not(/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='title'])">
                            <xsl:text> </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of
                                    select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='title']/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>

                </h1>

                <xsl:choose>
                    <xsl:when test="/dri:document/dri:meta/dri:userMeta/@authenticated = 'yes'">
                        <div id="ds-user-box">
                            <p>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                                        dri:metadata[@element='identifier' and @qualifier='url']"/>
                                    </xsl:attribute>
                                    <i18n:text>xmlui.dri2xhtml.structural.profile</i18n:text>
                                    <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                                    dri:metadata[@element='identifier' and @qualifier='firstName']"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                                    dri:metadata[@element='identifier' and @qualifier='lastName']"/>
                                </a>
                                <xsl:text> | </xsl:text>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                                        dri:metadata[@element='identifier' and @qualifier='logoutURL']"/>
                                    </xsl:attribute>
                                    <i18n:text>xmlui.dri2xhtml.structural.logout</i18n:text>
                                </a>
                            </p>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div id="ds-user-box">
                            <p>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="/dri:document/dri:meta/dri:userMeta/
                                        dri:metadata[@element='identifier' and @qualifier='loginURL']"/>
                                    </xsl:attribute>
                                    <i18n:text>xmlui.dri2xhtml.structural.login</i18n:text>
                                </a>
                            </p>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:call-template name="languageSelection" />
                
            </div>
        </div>
    </xsl:template>
    
    <!-- An example of an existing template copied from structural.xsl and overridden -->  
    <xsl:template name="buildFooter">
        <div id="ds-footer">
            This footer has had its text and links changed. This change should override the existing template.
            <div id="ds-footer-links">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath'][not(@qualifier)]"/>
                        <xsl:text>/contact</xsl:text>
                    </xsl:attribute>
                    <i18n:text>xmlui.dri2xhtml.structural.contact-link</i18n:text>
                </a>
                <xsl:text> | </xsl:text>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="/dri:document/dri:meta/dri:pageMeta/dri:metadata[@element='contextPath'][not(@qualifier)]"/>
                        <xsl:text>/feedback</xsl:text>
                    </xsl:attribute>
                    <i18n:text>xmlui.dri2xhtml.structural.feedback-link</i18n:text>
                </a>
            </div>
        </div>
    </xsl:template>

    
</xsl:stylesheet>
