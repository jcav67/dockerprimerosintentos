# FROM --platform=linux/amd64 node:19.2-alpine3.17'
FROM  --platform=$BUILDPLATFORM node:19.2-alpine3.17

#por defecto viene con una carpeta /app /usr /lib
# WORKDIR es un equivalente a cd app
WORKDIR /app

#copia archivos  a una carpeta destino  ./ quiere decir la carpeta actual
COPY package.json ./

# se ejectua el comando para installar dependencias, el RUN permite ejecutar comandos
RUN npm install

# una forma para copiar todo es . . 
COPY . .

#realizar   los test
RUN npm run test

# Eliminar archivos y directorios no necesarios en PROD
RUN rm -rf tests && rm -rf node_modules

# instalar unicamente dependencias de produccion
RUN npm install --prod

#CMD serie de comando que se quieren ejecutar, por lo general la ultima ya que dice como se inicia la aplicacion
CMD [ "node","app.js" ]