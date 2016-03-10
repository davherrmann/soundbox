<soundbox>

  <h3>{ opts.title }</h3>

  <ul>
    <li each={ items }>
      <label class={ completed: done }>
        { text }
        <button onclick={ play }>Play</button>
      </label>
    </li>
  </ul>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit }>
    <button disabled={ !text }>Add sound #{ items.length + 1 }</button>
  </form>

  <script>
    this.items = []

    this.on('mount', function() {
      this.requestSoundFiles();
    });

    edit(e) {
      this.text = e.target.value;
    }

    add(e) {
      if (!this.text) {
        return;
      }
      let text = this.text;
      this.items.push({ text: text });
      this.text = this.input.value = '';

      this.sendToServer(text);
    }

    play(e) {
      var http = new XMLHttpRequest();

      http.open("GET", "play?id=" + e.item.id, true);
      http.send();
    }

    requestSoundFiles() {
      var http = new XMLHttpRequest();
      var self = this;

      http.onload = function(e) {
        let soundFiles = JSON.parse(http.responseText);
        self.items = soundFiles;
        self.update();
      }

      http.open("GET", "sounds", true);
      http.send();
    }

    sendToServer(text) {
      var http = new XMLHttpRequest();

      http.open("GET", "add?text=" + text, true);
      http.send();
    }
  </script>

</soundbox>
