<script lang="ts">
	import { browser } from "$app/env";
	import ChatList from "$lib/ChatList.svelte";

	type Chats = {
		id: string;
		groupData: {
			title: string;
			description: string;
			connected: number;
		};
	};

	let loggedIn = false;
	let username = "";
	let chats: Chats[] = [];
	let chatWS: WebSocket;
	let error = false;

	if (browser) {
		chatWS = new WebSocket(`ws://localhost:8765/chat`);
		chatWS.onerror = (err) => {
			error = true;
		};

		chatWS.onmessage = (message) => {
			let result = JSON.parse(message.data);
			if (result.type === "chatlist") {
				console.log(result);
				chats = result.data;
			}
		};
		chatWS.onopen = () => {
			chatWS.send(JSON.stringify({ type: "getChats" }));
		};
		let localData = localStorage.getItem("username");
		if (localData) {
			username = localData;
		}
	}
	const setInput = () => {
		if (browser) {
			localStorage.setItem("username", username);
			loggedIn = true;
		}
	};
</script>

<div class="container">
	<div class="card">
		{#if loggedIn === false}
			<div class="login-container">
				<h1>Set your username</h1>
				<p>Must be in between of 3-18 characters</p>
				<input bind:value={username} type="text" placeholder="Ticua07" />
				<button on:click={setInput}>Enter chats</button>
			</div>
		{:else if error === true}
			<div class="error-container">
				<h1>An error has occurred.</h1>
				<p>Server might be down. <br /> come back in a minute.</p>
			</div>
		{:else}
			<h1 class="title">Chats | {username}</h1>
			<hr />
			<ChatList {chats} socket={chatWS} />
		{/if}
	</div>
</div>

<style>
	@import url("https://fonts.googleapis.com/css2?family=Poppins&display=swap");
	.container {
		background-color: #333;
		height: 100vh;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.error-container {
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: white;
	}
	.error-container > h1 {
		font-size: 3rem;
		text-align: center;
	}
	.error-container > p {
		font-size: 1.2rem;
		text-align: center;
	}

	.login-container {
		height: 100%;
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: white;
		gap: 20px;
	}
	.login-container > h1 {
		font-size: 3rem;
	}
	.login-container > input {
		width: 250px;
		border: 0;
		outline: 0;
		padding: 10px;
		font-size: 18px;
		border-radius: 5px;
	}
	.login-container > button {
		border: 0;
		outline: none;
		border-radius: 5px;
		padding-block: 10px;
		padding-inline: 25px;
		font-size: 16px;
		background-color: #1d4ed8;
		color: white;
	}
	.login-container > button:hover {
		background-color: #1e3a8a;
	}

	.card {
		background-color: #18181b;
		height: 100%;
		max-height: 800px;
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
		font-family: "Poppins";
		font-size: 2.5rem;
	}
	hr {
		border-color: #999;
		width: 100%;
		margin-bottom: 10px;
	}
</style>
