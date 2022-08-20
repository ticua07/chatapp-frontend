<script lang="ts">
	import { goto } from "$app/navigation";
	import { browser } from "$app/env";
	import Messages from "./Messages.svelte";

	type Message = {
		author: string;
		content: string;
	};

	let username: string;
	if (browser) {
		let data = localStorage.getItem("username");
		if (data) {
			username = data;
		} else {
			goto("/");
		}
	}

	export let id: string;
	let messages: Message[] = [];
	let inputValue = "";

	const addMessage = () => {
		if (inputValue.trim() === "") {
			return;
		}
		console.log(`Got new message: ${inputValue}`);
		messages = [...messages, { author: "Ticua07", content: inputValue }];
		inputValue = ""; // clear input
	};

	const handleSendInput = (event: Event) => {
		event.preventDefault();
		addMessage();
	};
</script>

<div class="card">
	<div class="navbar">
		<!-- Font Awesome Pro 6.1.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2022 Fonticons, Inc. -->
		<a href="/">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
				<path
					d="M447.1 256C447.1 273.7 433.7 288 416 288H109.3l105.4 105.4c12.5 12.5 12.5 32.75 0
				45.25C208.4 444.9 200.2 448 192 448s-16.38-3.125-22.62-9.375l-160-160c-12.5-12.5-12.5-32.75
				0-45.25l160-160c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25L109.3 224H416C433.7 224 447.1
				238.3 447.1 256z"
				/>
			</svg>
		</a>
		<h1>Chat Title | id={id} | username={username}</h1>
	</div>
	<hr />
	<div class="chat">
		<Messages bind:data={messages} />
	</div>
	<hr />
	<div class="message__bar">
		<form on:submit={handleSendInput}>
			<input
				bind:value={inputValue}
				type="text"
				class="message__input"
				placeholder="I brought pizza!"
			/>
			<button class="message__send" type="submit">Send</button>
		</form>
	</div>
</div>

<style>
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
	.navbar {
		width: 100%;
		color: white;
		display: flex;
		flex-direction: row;
		align-items: center;
		gap: 15px;
		margin-bottom: 15px;
	}
	.navbar > a {
		width: 43px;
		height: 43px;
		fill: white;
	}

	.chat {
		width: 100%;
		flex: 0.95;
	}
	.message__bar {
		border-top: black 1px solid;
		flex: 0.05;
		display: flex;
		width: 100%;
	}
	.message__input {
		flex: 0.8;
		width: 100%;
		border: 0;
		outline: none;
		border-radius: 15px;
		padding-left: 15px;
		font-size: 1.25rem;
	}
	.message__send {
		flex: 0.2;
		width: 100%;
		border: 0;
		outline: none;
		border-radius: 15px;
		padding-block: 10px;
		padding-inline: 25px;
		font-size: 16px;
		background-color: #1d4ed8;
		color: white;
	}
	.message__send:hover {
		background-color: #1e3a8a;
	}
	hr {
		border-color: #999;
		width: 100%;
		margin-bottom: 10px;
	}
	form {
		display: flex;
		width: 100%;
		gap: 15px;
	}
</style>
