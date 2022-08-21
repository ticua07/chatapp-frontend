<script>
	import { page } from "$app/stores";
	import Chat from "$lib/Chat.svelte";
</script>

<div class="container">
	<Chat id={$page.params.chatID} />
</div>

<style>
	.container {
		background-color: #333;
		height: 100vh;
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
