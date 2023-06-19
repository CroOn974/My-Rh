const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  //   devServer: {
  //   proxy: {
  //     '/api': {
  //       target: 'http://localhost:8000', // Remplacez par l'adresse de votre serveur Django
  //       ws: true,
  //       changeOrigin: true,
  //     },
  //   },
  // },
  devServer: {
    proxy: {
      '/api': {
        target: 'http://backend:8000',
        changeOrigin: true
      }
    }
  },
})
