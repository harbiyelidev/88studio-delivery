fx_version 'cerulean'
game {'gta5'}
lua54 'yes'

author '88 Studio'
name '88 Studio - Delivery Job'
description 'Add innovation to your server with the courier profession with a tiered system! | 88studio.tebex.io'

developer 'vezironi'
developer_discord 'https://discord.gg/hdstore'

discord 'https://discord.gg/88studio'
website 'https://88studio.tebex.io/'
tutorial 'https://88studio.gitbook.io/documentation/'

scriptname '88studio-delivery'
version '1.0.0'

shared_scripts {
    'shared/getcore.lua',
    'config/*.lua',
    'locales/*.lua',
}

client_scripts {
    'client/main.lua',
    'client/commands.lua',
    'shared/client_functions.lua',
}

server_scripts {
    'server/main.lua',
    'server/version_checker.lua',
    'shared/server_functions.lua',
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'shared/*.lua',
}

files {
    'ui/index.html',
    'ui/assets/audio/*.wav',
    'ui/assets/css/index.css',
    'ui/assets/fonts/*.ttf',
    'ui/assets/image/*.png',
    'ui/assets/image/*.svg',
    'ui/assets/js/*.js',
    'ui/app/index.js',
    'ui/app/utils/importTemplate.js',
    'ui/app/pages/**/*.html',
    'ui/app/pages/**/*.css',
    'ui/app/pages/**/*.js',
}

ui_page 'ui/index.html'

dependencies {
    '88studio-core',
}

dependency '/assetpacks'