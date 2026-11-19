# NEXLIVE — starter de cuentas y streaming

Base técnica inicial para desarrollar NEXLIVE. Incluye registro/inicio de sesión con Supabase y una sala de emisión con LiveKit.

## Requisitos
- Node.js 20.9 o superior
- Proyecto Supabase
- Proyecto LiveKit Cloud

## Instalación
1. Copia `.env.example` a `.env.local` y completa las credenciales.
2. Ejecuta `npm install`.
3. Ejecuta el SQL de `supabase/schema.sql` en el SQL Editor de Supabase.
4. Ejecuta `npm run dev` y abre http://localhost:3000.

## Importante
Este repositorio es un starter, no una plataforma terminada ni una APK. Antes de producción faltan, entre otras cosas, catálogo real de canales, chat persistente, moderación completa, notificaciones, pruebas, despliegue, políticas de privacidad y aplicación Android. Nunca publiques claves secretas ni `.env.local`.
