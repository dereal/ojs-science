{**
 * plugins/generic/announcementFeed/templates/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement feed plugin navigation sidebar.
 *
 *}

<h4 class="side">{translate key="announcement.announcements"}</h4>
<div class="edit-pics" id="sidebarAnnouncementFeed">
	<a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"atom"}">
	<img src="{$baseUrl}/plugins/generic/announcementFeed/templates/images/atom10_logo.gif" alt="{translate key="plugins.generic.announcementfeed.atom.altText"}" border="0" /></a>
	<br/>
	<a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss2"}">
	<img src="{$baseUrl}/plugins/generic/announcementFeed/templates/images/rss20_logo.gif" alt="{translate key="plugins.generic.announcementfeed.rss2.altText"}" border="0" /></a>
	<br/>
	<a href="{url page="gateway" op="plugin" path="AnnouncementFeedGatewayPlugin"|to_array:"rss"}">
	<img src="{$baseUrl}/plugins/generic/announcementFeed/templates/images/rss10_logo.gif" alt="{translate key="plugins.generic.announcementfeed.rss1.altText"}" border="0" /></a>
</div>