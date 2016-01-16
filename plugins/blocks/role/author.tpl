{**
 * plugins/blocks/role/author.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Author navigation sidebar.
 *
 *}
<h4 class="side">{translate key="user.role.author"}</h4>
<div class="edit-pics" id="sidebarAuthor">
	<p class="help-block">{translate key="article.submissions"}</p>
	<ul class="stay">
		<li><a href="{url op="index" path="active"}">{translate key="common.queue.short.active"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
		<li><a href="{url op="index" path="completed"}">{translate key="common.queue.short.completed"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
		<li><a href="{url op="submit"}">{translate key="author.submit"}</a></li>
	</ul>
</div>
