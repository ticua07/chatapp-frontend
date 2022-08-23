<script lang="ts">
	type Chat = {
		id: string;
		groupData: {
			title: string;
			description: string;
			connected: number;
		};
	};
	export let chats: Chat[];
	export let socket: WebSocket;
	let name: string;
	let description: string;
	let error = false;

	const handleCreateChat = () => {
		if (name && description) {
			error = false;

			if (socket && socket.OPEN) {
				socket.onmessage = (message) => {
					let result = JSON.parse(message.data);
					if (result.type === "chatlist") {
						console.log(result);
						chats = result.data;
					} else if (result.type === "created") {
						console.log("This is handleCreateChat");
						console.log(message);
					}
				};
				socket.send(JSON.stringify({ type: "create", title: name, description: description }));
				socket.send(JSON.stringify({ type: "getChats" }));
			}
		} else {
			error = true;
		}
	};
</script>

<div class="container">
	<div
		class="create-form"
		onsubmit={(e) => {
			e.preventDefault();
		}}
	>
		<input type="text" bind:value={name} />
		<input type="text" bind:value={description} />
		<button class="join__button" on:click={handleCreateChat}>Create chat</button>
		{#if error}
			<p class="error">Error creating chat, Check if name or description is missing.</p>
		{/if}
	</div>

	{#each chats as chat}
		<div class="card">
			<h1>{chat.groupData.title}</h1>
			<p>{chat.groupData.description}</p>
			<small>There is {chat.groupData.connected} people connected</small>

			<a href={`/chat/${chat.id}`}><button class="join__button">Entrar</button></a>
			<!-- <p>{chat.id}</p> -->
		</div>
	{/each}
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

	.create-form {
		display: flex;
		flex-direction: column;
		gap: 5px;
		padding: 10px;
	}

	.create-form > input {
		height: 30px;
		border-radius: 15px;
		padding-left: 15px;
		border: 0;
		outline: 0;
	}

	.error {
		color: white;
		font-weight: bold;
		text-align: center;
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

	.card::selection {
		/* Set selection colors to defaul */
		color: initial;
		background-color: initial;
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
