
<div id="player1" class="aplayer"></div>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/aplayer/1.10.1/APlayer.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/aplayer/1.10.1/APlayer.min.js"></script>
<script type="text/javascript">
const apo = new APlayer({
    container: document.getElementById('player1'),
    fixed: true,
    autoplay: false,
    audio: [{
        name: '周杰伦',
        artist: '水管的友情',
        url: '/uploads/水管的友情.flac',
        cover: '/uploads/水管的友情.jpg',
    }]
});
</script>
