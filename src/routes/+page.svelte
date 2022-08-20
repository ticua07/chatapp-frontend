<script>
	import ChatList from '$lib/ChatList.svelte';
	let chats = [
		{
			id: '1',
			title: 'Chat 1 only',
			description: 'Chat 1 ⛔'
		},
		{
			id: '2',
			title: 'goodbye',
			description: 'my world'
		}
	];
</script>

<div class="container">
	<div class="card">
		<h1 class="title">Chats</h1>
		<hr />
		<ChatList {chats} />
	</div>
</div>

<style>
	@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
	.container {
		background-color: #333;
		height: 100vh;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.card {
		background-color: #18181b;
		height: 800px;
		max-width: 800px;
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		border-radius: 5px;
		padding: 10px;
	}
	.title {
		-webkit-font-smoothing: antialiased;
		color: white;
		font-weight: 400;
		font-family: 'Poppins';
		font-size: 2.5rem;
	}
	hr {
		border-color: #999;
		width: 100%;
		margin-bottom: 10px;
	}
</style>
