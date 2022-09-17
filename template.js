let granimInstance = new Granim({
    element: '#canvas-basic',
    direction: 'left-right',
    isPausedWhenNotInView: true,
    states : {
        "default-state": {
            gradients: [
                ['#EC6B5E', '#3c57ce'],
                ['#7abd6f', '#3951b2'],
            ]
        }
    }
});
