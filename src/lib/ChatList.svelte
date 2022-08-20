<script lang="ts">
	type Chat = {
		id: string;
		title: string;
		description: string;
	};
	export let chats: Chat[];
	console.log(chats);
</script>

<div class="container">
	{#each chats as chat}
		<div class="card">
			<h1>{chat.title}</h1>
			<p>{chat.description}</p>

			<a href={`/chat/${chat.id}`}><button class="join__button">Entrar</button></a>
			<!-- <p>{chat.id}</p> -->
		</div>
	{/each}
	<!-- <div class="card">
		<h2>Title</h2>
		<p>Simple description Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
		<a href="/#"><button class="join__button">Entrar</button></a>
	</div> -->
</div>

<style>
	.container {
		overflow-y: scroll;
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.container::-webkit-scrollbar {
		display: none;
	}

	p {
		font-size: 18px;
	}

	.card {
		color: #1c1917;
		background-color: #f4f4f5;
		padding: 5px;
		border-radius: 5px;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	a {
		width: fit-content;
	}

	.join__button {
		border: 0;
		border-radius: 5px;
		padding-block: 10px;
		padding-inline: 25px;
		font-size: 16px;
		background-color: #1d4ed8;
		color: white;
	}
	.join__button:hover {
		background-color: #1e3a8a;
	}
</style>
