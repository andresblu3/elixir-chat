<script>
	import { Socket } from 'phoenix';

	// Obtener la IP actual desde donde se está accediendo a la página
	let host = window.location.hostname;

	let socket = new Socket(`ws://${host}:4000/socket`, { params: {} });
	let messages = [];
	let message = '';

	socket.connect();

	let channel = socket.channel("room:lobby", {});

	channel.join()
		.receive("ok", resp => { console.log("Joined successfully", resp); })
		.receive("error", resp => { console.log("Unable to join", resp); });

	channel.on("new_msg", payload => {
		messages = [...messages, payload.body];
	});

	function sendMessage() {
		if (message.trim() === '') return;
		channel.push("new_msg", { body: message });
		message = '';
	}
</script>

<main>
	<h1>Chat</h1>
	<ul>
		{#each messages as msg}
			<li>{msg}</li>
		{/each}
	</ul>

	<input bind:value={message} placeholder="Escribe un mensaje" />
	<button on:click={sendMessage}>Enviar</button>
</main>

<style>
/* Tu estilo aquí */
</style>
