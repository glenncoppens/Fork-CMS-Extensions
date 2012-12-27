{* Title *}
	<h3>{$blockPhotogalleryAlbum.title}</h3>

{* Meta *}
	<ul>
		<li>
			{* Written on *}
			{$blockPhotogalleryAlbum.publish_on|date:{$dateFormatLong}:{$LANGUAGE}}

			{* Category*}
			{option:blockPhotogalleryAlbum.category_title}
				{$lblIn} {$lblThe} {$lblCategory} 
				<a href="{$blockPhotogalleryAlbum.category_full_url}" title="{$blockPhotogalleryAlbum.category_title}">{$blockPhotogalleryAlbum.category_title}</a>
				{option:!blockPhotogalleryAlbum.tags}.{/option:!blockPhotogalleryAlbum.tags}
			{/option:blockPhotogalleryAlbum.category_title}
			
			
			{* Category*}
			{option:blockPhotogalleryAlbum.categories}
				{$lblIn} {$lblThe} {$lblCategory} 
				{iteration:blockPhotogalleryAlbum.categories}
					<a href="{$blockPhotogalleryAlbum.categories.full_url}" rel="tag" title="{$blockPhotogalleryAlbum.categories.title}">{$blockPhotogalleryAlbum.categories.title}</a>{option:!blockPhotogalleryAlbum.categories.last}, {/option:!blockPhotogalleryAlbum.categories.last}{option:blockPhotogalleryAlbum.categories.last}.{/option:blockPhotogalleryAlbum.categories.last}
				{/iteration:blockPhotogalleryAlbum.categories}
			{/option:blockPhotogalleryAlbum.categories}
			
			{* Tags*}
			{option:blockPhotogalleryAlbum.tags}
				{$lblWith} {$lblThe} {$lblTags}
				{iteration:blockPhotogalleryAlbum.tags}
					<a href="{$blockPhotogalleryAlbum.tags.full_url}" rel="tag" title="{$blockPhotogalleryAlbum.tags.name}">{$blockPhotogalleryAlbum.tags.name}</a>
					{option:!blockPhotogalleryAlbum.tags.last}, {/option:!blockPhotogalleryAlbum.tags.last}
					{option:blockPhotogalleryAlbum.tags.last}.{/option:blockPhotogalleryAlbum.tags.last}
				{/iteration:blockPhotogalleryAlbum.tags}
			{/option:blockPhotogalleryAlbum.tags}
		</li>
	</ul>


{* Content *}
	{option:blockPhotogalleryAlbum.text}
		{$blockPhotogalleryAlbum.text}
	{/option:blockPhotogalleryAlbum.text}

	{option:!blockPhotogalleryAlbum.text}
		{$blockPhotogalleryAlbum.introduction}
	{/option:!blockPhotogalleryAlbum.text}


{* Lightbox *}
	{option:lightbox}
		{option:blockPhotogalleryAlbum.images}
			<ul class="photogalleryDetailLightbox">
				{iteration:blockPhotogalleryAlbum.images}
				<li>
					<a data-image_id="{$blockPhotogalleryAlbum.images.id}" href="{$var|createimage:{$blockPhotogalleryAlbum.images.set_id}:{$blockPhotogalleryAlbum.images.filename}:{$modulePhotogalleryDetailLargeResolution}}" rel="{$blockPhotogalleryAlbum.id}" class="linkedImage linkOverlay" title="{$blockPhotogalleryAlbum.images.title}">

						<img src="{$var|createimage:{$blockPhotogalleryAlbum.images.set_id}:{$blockPhotogalleryAlbum.images.filename}:{$modulePhotogalleryDetailThumbnailResolution}}" />

					</a>
					<div class="caption">
						{option:blockPhotogalleryAlbum.images.title}<h3>{$blockPhotogalleryAlbum.images.title}</h3>{/option:blockPhotogalleryAlbum.images.title}
						{$blockPhotogalleryAlbum.images.text}
					</div>
				</li>
				{/iteration:blockPhotogalleryAlbum.images}
			</ul>
		{/option:blockPhotogalleryAlbum.images}
	{/option:lightbox}


{* Paged *}
	{option:paged}
		{option:blockPhotogalleryAlbum.images}
			<ul>
				{iteration:blockPhotogalleryAlbum.images}
				<li>
					<a href="{$blockPhotogalleryAlbum.images.full_url}" rel="{$blockPhotogalleryAlbum.id}" class="linkedImage" title="{$blockPhotogalleryAlbum.image.title}">
						<img src="{$var|createimage:{$blockPhotogalleryAlbum.images.set_id}:{$blockPhotogalleryAlbum.images.filename}:{$modulePhotogalleryDetailThumbnailResolution}}" />
					</a>
				</li>
				{/iteration:blockPhotogalleryAlbum.images}
			</ul>
		{/option:blockPhotogalleryAlbum.images}
	{/option:paged}


{* Navigation *}
	<ul class="photogalleryDetailAlbumsNavigation">
		{option:blockPhotogalleryAlbumNavigation.previous}
			<li class="previousLink">
				<a href="{$blockPhotogalleryAlbumNavigation.previous.url}" rel="prev">{$lblPreviousAlbum|ucfirst}: <em>{$blockPhotogalleryAlbumNavigation.previous.title}</em></a>
			</li>
		{/option:blockPhotogalleryAlbumNavigation.previous}
		{option:blockPhotogalleryAlbumNavigation.next}
			<li class="nextLink">
				<a href="{$blockPhotogalleryAlbumNavigation.next.url}" rel="next">{$lblNextAlbum|ucfirst}: <em>{$blockPhotogalleryAlbumNavigation.next.title}</em></a>
			</li>
		{/option:blockPhotogalleryAlbumNavigation.next}
	</ul>