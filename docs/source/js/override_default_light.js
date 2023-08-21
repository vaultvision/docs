const loadTheme = () => {
    let theme = localStorage.getItem('theme');
    if (theme !== null) {
        if (theme === 'dark') {
            document.documentElement.setAttribute('data-theme', 'dark');
        } else {
            document.documentElement.setAttribute('data-theme', 'light');
        }
    } else {
        theme = 'light'; // default

        if (window.matchMedia) {
            const match = window.matchMedia('(prefers-color-scheme: dark)')
            if (match.matches) {
                theme = 'dark';
            }

            match.addEventListener('change', e => {
                if (match.matches) {
                    document.documentElement.setAttribute('data-theme', 'dark');
                } else {
                    document.documentElement.setAttribute('data-theme', 'light');
                }
            })
        }

        document.documentElement.setAttribute('data-theme', theme);
    }
};

loadTheme();
