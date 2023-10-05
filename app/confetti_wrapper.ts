// Demonstrate some raw typescript

import JSConfetti from 'js-confetti'

let jsConfetti : JSConfetti;

export function init () {
	jsConfetti = new JSConfetti();
}

export function make_confetti() {
	jsConfetti.addConfetti();
}

