function debouceFc(src,delay) {
    let text = "";
    let timeoutId;
    return function () {
        if (timeoutId) {
            clearTimeout(timeoutId);
        }
        timeoutId = setTimeout(() => {
            text = src;
            timeoutId = null;
        }, delay);
        return text;
    };
}

export default debouceFc;