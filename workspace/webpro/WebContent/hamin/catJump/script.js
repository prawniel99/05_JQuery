const character = document.getElementById('character');
const obstacle = document.getElementById('obstacle');

document.addEventListener('keydown', function(event) {
    if (event.code === 'Space') {
        jump();
		// shake();
    }
});

function jump() {
    if (!character.classList.contains('jump')) {
        character.classList.add('jump');
        setTimeout(function() {
            character.classList.remove('jump');
        }, 500); // jump animation duration
    }
}

function shake() {
    if (!character.classList.contains('shake')) {
        character.classList.add('shake');
        setTimeout(function() {
            character.classList.remove('shake');
        }, 500); // jump animation duration
    }
}

setInterval(function() {
    const characterBottom = parseInt(window.getComputedStyle(character).getPropertyValue('bottom'));
    const obstacleRight = parseInt(window.getComputedStyle(obstacle).getPropertyValue('right'));

    // Detect collision
    if (obstacleRight > 830 && obstacleRight < 850 && characterBottom < 0) {
        alert('Game Over');
        location.reload();
    }
}, 1);
