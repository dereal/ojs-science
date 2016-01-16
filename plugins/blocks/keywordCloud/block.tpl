{**
 * plugins/blocks/keywordCloud/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}
 <h4 class="side">{translate key="plugins.block.keywordCloud.title"}</h4>
<div class="edit-pics" id="sidebarKeywordCloud">
	{foreach name=cloud from=$cloudKeywords key=keyword item=count}
		<a href="{url page="search" subject=$keyword}"><span style="font-size: {math equation="round(((x-1) / y * 100)+75)" x=$count y=$maxOccurs}%;">{$keyword}</span></a>
	{/foreach}
</div>
