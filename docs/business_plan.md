# ZebraPace — Modelo de negocio

Documento de trabajo · versión 2 · 21 de noviembre de 2026
Comparte principios, precios, beca, IA y riesgos con ZebraUp (ver `zebraup-modelo-de-negocio.md`, secciones 1, 3, 4, 7 y 8).

---

## 1. Principio rector (resumen)

El registro es gratis y la app funciona sin cuenta y sin conexión. Se cobra solo por lo que tiene un costo real por uso o ahorra tiempo. Nunca se cobra por registrar, tener cuenta, sincronizar, exportar, borrar ni por **evitar hacerse daño hoy**.

*El pasado es información; el presente es seguridad.* En ZebraPace esto pesa más que en ZebraUp, porque la app corrige la carga del día. Poner el freno detrás de un pago sería vender el freno.

---

## 2. Gratis y de pago

| Función | Gratis | Pago |
|---|:---:|:---:|
| Importar pasos, sueño y frecuencia cardíaca (Apple Health / Health Connect) | ✓ | |
| Planificación del movimiento del día, techo y piso de carga | ✓ | |
| Registro de sesiones y síntomas posteriores | ✓ | |
| Ajuste automático de carga ante un pico de síntomas | ✓ | |
| Aviso de techo de carga y línea de precaución por malestar post-esfuerzo | ✓ | |
| Plan de ejercicio progresivo (escalera adaptada: un nivel se desbloquea tras completarlo cómodo 3 veces) | ✓ | |
| Registro de días de crisis, descanso y terapia | ✓ | |
| Rayas de "showing up" (el descanso cuenta), reinicio mensual y recuento anual | ✓ | |
| Cuestionario TSK-17 y mensajes de ánimo basados en evidencia | ✓ | |
| Comparación simple con las últimas semanas (línea base para el pacing) | ✓ | |
| Superposición del clima (Open-Meteo, sin costo de API) | ✓ | |
| Cuenta, sincronización entre dispositivos y Juntos | ✓ | |
| Exportar y borrar todos los datos | ✓ | |
| Resumen en PDF del período (exportación general, sin plantilla clínica) | ✓ | |
| Detección de patrones de largo plazo (desfase de malestar post-esfuerzo, subgrupos) | | Plan anual |
| Historial largo de carga acumulada y proyecciones | | Plan anual |
| Comparación entre períodos largos (este invierno vs. el anterior) | | Plan anual |
| Informe de actividad para kinesiología o fisiatría con plantilla | | Plan anual |
| Crear un plan desde texto con IA (la IA transcribe, la persona revisa en el editor) | | Plan anual (propuesto) |
| Resumen semanal narrativo con IA en la nube | | Créditos |
| Resumen con IA en el dispositivo (iPhone compatible) | ✓ | |

**Notas:**
- La comparación con las últimas semanas es gratis porque el pacing *es* comparar con la línea base reciente. Lo de pago es profundidad, no fecha.
- El ajuste de carga y los avisos de techo son gratis y no negociables.
- Juntos depende de la cuenta y la sincronización; por eso ambas son gratis en las dos apps.
- El Resumen en PDF es gratis porque es una forma de exportar. Lo de pago es la plantilla para kinesiología o fisiatría construida sobre él.
- El clima es gratis: no tiene costo de API y ayuda a explicar los picos de hoy, así que es presente, no profundidad.
- Crear el plan a mano en el editor sigue siendo gratis. Lo de pago es el atajo con IA (ver 4.7).

### Por decidir
- Widgets y Apple Watch / Wear OS: ¿gratis o plan anual?

---

## 3. Precios, beca e IA

Son los mismos que en ZebraUp: un solo **plan anual Zebras+** que cubre ambas apps (9.990 CLP / US$19,99), plan mensual opcional (990 CLP / US$2,99; precios en Chile cambiados el 21-11-2026 al configurar App Store Connect), paquete de créditos de IA (490 CLP), apadrinar como compra dentro de la app y beca instantánea con un botón. Detalle completo en el documento de ZebraUp, secciones 3, 4 y 7.

**Regla de IA específica de ZebraPace:** la IA puede resumir la semana y redactar ánimo, pero **nunca** decide subir la carga ni anula un aviso de techo o de malestar post-esfuerzo. Las decisiones de seguridad las toma la lógica de la app, no un modelo.

---

## 4. Cómo se cobra

### 4.1 Un solo permiso para las dos apps

Apple y Google venden suscripciones por app: no existe una suscripción que valga para dos apps distintas. Por eso:

- **Las dos apps venden el mismo plan** Zebras+ como compra dentro de la app. La regla 3.1.3(b) de Apple (servicios multiplataforma) permite reconocer en una app lo comprado en otra, siempre que también se pueda comprar ahí.
- **El permiso vive en la cuenta**, no en la tienda. Se compra en cualquiera de las dos apps y se reconoce en la otra al iniciar sesión con la misma cuenta de Supabase.
- **RevenueCat** resuelve esto sin programarlo a mano: un proyecto con las dos apps, un permiso `zebras_plus` y, como identificador de usuario, el mismo id de Supabase. Un webhook copia el estado a una tabla `entitlements` en Supabase para las revisiones que ocurren en el servidor.
- Comprar el plan exige cuenta; usar lo gratis, no.

### 4.2 Un solo punto de control en la app

- Un único provider (`isPlusProvider`) decide qué se muestra. Ninguna pantalla consulta la tienda directamente.
- **Se cobra por la vista, no por el dato.** Todo se registra siempre. Al suscribirse, el análisis aparece al instante con todo el historial.
- **Si el plan vence, no se borra nada:** se ocultan las vistas profundas y se mantiene la exportación completa.
- **Sin conexión:** el estado del plan se guarda en el teléfono con unos 7 días de margen, para no bloquear a nadie por estar desconectado.

### 4.3 La seguridad queda fuera del cobro, por diseño

La lógica de seguridad (`pacing_service`, los avisos de `pem_service` y el techo de carga) **no puede importar** `isPlusProvider`. Un test automático falla si alguno lo hace. Así, la regla "no se vende el freno" vive en el código y no solo en este documento.

Caso límite: si la app usa el desfase de malestar post-esfuerzo aprendido para avisar *hoy*, ese aviso es gratis. Lo de pago es el gráfico y la explicación del patrón a lo largo de meses.

### 4.4 Cómo se controla cada función de pago

| Función | Control |
|---|---|
| Detección de patrones de largo plazo | Gratis hasta N semanas (la línea base); de pago más allá. Una sola constante. |
| Historial largo de carga y proyecciones | El mismo límite de N semanas en los gráficos. |
| Comparación entre períodos largos | Pantalla propia, solo con plan. |
| Informe para kinesiología o fisiatría | Plantilla de pago sobre el Resumen en PDF, que sigue gratis. |
| Resumen semanal con IA en la nube | Edge Function de Supabase que revisa y descuenta créditos en el servidor. |

**Decidido (21-11-2026):** N = 13 semanas (91 días), para que el rango de 90 días que ya tenían quienes prueban siga gratis. Lo de pago es el largo de la ventana, no la fecha: una ventana gratis puede estar en cualquier parte del historial.

### 4.5 Créditos, beca y apadrinar

- **Créditos de IA:** compra consumible. El saldo vive en Supabase y la Edge Function lo descuenta de forma atómica antes de llamar al modelo. El teléfono nunca decide si quedan créditos.
- **Beca:** el botón llama a una Edge Function que otorga el permiso promocional mediante la API de RevenueCat. No pasa por la tienda ni pide justificación.
- **Año gratis para quienes prueban:** promesa pública en zebras.paulinavl.com/compare/. Al lanzar, se otorga un año de `zebras_plus` como permiso promocional a las cuentas de Supabase creadas durante la prueba. Quien probó sin cuenta tiene que crear una para recibirlo, así que hay que avisarlo antes del lanzamiento.
- **Apadrinar:** compra consumible que suma una beca a un fondo común. Se presenta como regalar un plan, no como donación: en Apple, solo las organizaciones sin fines de lucro aprobadas pueden recibir donaciones dentro de la app.

### 4.6 Resumen con IA gratis en Android

El resumen en el dispositivo existe solo en iPhone compatibles. **Por decidir:** si Android tiene una alternativa en el dispositivo o si usa solo créditos.

### 4.7 Crear un plan desde texto con IA (propuesta, 22-11-2026)

El editor de Plan es la parte más engorrosa de la app, y casi todos ya tienen su plan escrito en algún lado: lo que entregó la kinesióloga, una nota o un PDF. La idea es pegar o escribir ese texto y que la IA lo convierta en un plan.

- **La IA solo transcribe.** Convierte el texto al mismo formato JSON que ya usa la importación de planes. No inventa ejercicios ni decide cargas; si algo no está claro, lo marca en vez de adivinar.
- **Siempre pasa por el editor.** El resultado se abre como borrador; la persona lo revisa, corrige y guarda. Nada se guarda sin revisión.
- **No se vende el freno.** Las fases con condiciones de paso, la progresión, el modo brote y las señales de alto quedan en el código y gratis; la IA no puede saltárselas.
- **Más adelante:** aceptar también una foto de la hoja de la kinesióloga.

**Por decidir:**
- Cobro: dentro de Zebras+ con un tope mensual (por ejemplo 5 planes al mes) o con créditos. Se recomienda Zebras+: se usa pocas veces, cuesta poco por uso y le da valor a la suscripción.
- Dónde corre: en el dispositivo (modelo de Apple con salida estructurada, en iPhone compatibles; el texto médico no sale del teléfono) o en una Edge Function en la nube (Android e iPhone antiguos).
- Privacidad: si va a la nube, se envía solo el texto, sin la cuenta, y no se guarda. Hay que explicarlo en la política de privacidad.

---

## 5. Estado actual

- Prueba cerrada en Google Play (aún no hay suficientes testers para la abierta) ("ZebraPace: pacing & symptoms").
- iOS en TestFlight (dos builds enviados).
- Supabase en plan gratuito.
- ZebraPace se publica primero, para equivocarse con menos riesgo, y después se lanza ZebraUp con más confianza.

---

## 6. Pendientes

- [x] Clima: gratis
- [x] Renombrar el informe a "Resumen en PDF" (gratis)
- [ ] Decidir widgets y reloj (gratis o plan)
- [x] Decidir N: 13 semanas
- [ ] Decidir el resumen con IA en Android
- [ ] Crear un plan desde texto con IA: decidir cobro (Zebras+ o créditos), dónde corre y privacidad (4.7)
- [ ] Configurar RevenueCat con las dos apps y el permiso `zebras_plus`
- [x] Crear `isPlusProvider` y el test que separa la seguridad del cobro
- [ ] Antes del lanzamiento: avisar a quienes prueban sin cuenta que creen una para recibir el año gratis
- [ ] Definir el formato del informe para kinesiología o fisiatría
- [ ] Implementar compras dentro de la app compartidas con ZebraUp (mismo plan, misma cuenta)
- [ ] Revisar App Review Guidelines y la política de pagos de Google Play (ver documento de ZebraUp)
- [ ] Publicar la tabla de funciones en zebras.paulinavl.com