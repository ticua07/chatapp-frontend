<script lang="ts">
	type Message = {
		author: string;
		content: string;
	};
	export let data: Message[];
</script>

<ul class="messages">
	{#each data as msg}
		<li class="message">{msg.author}: {msg.content}</li>
	{/each}
</ul>

<style>
	.messages {
		color: white;
		list-style: none;
		overflow-y: scroll;
		max-height: 660px;
	}
	.messages::-webkit-scrollbar {
		display: none;
	}
	.message {
		font-size: 20px;
	}
</style>
