 "use client";
import "@livekit/components-styles"; import {LiveKitRoom,VideoConference} from "@livekit/components-react"; import {useState} from "react";
export default function Studio(){const [token,setToken]=useState("");const [error,setError]=useState("");
async function connect(){setError("");const r=await fetch("/api/livekit/token",{method:"POST"});const d=await r.json();if(!r.ok){setError(d.error||"No se pudo conectar");return;}setToken(d.token);}
if(!token)return <div className="panel"><button className="btn" onClick={connect}>Conectar cámara y micrófono</button><p className="muted">{error}</p></div>;
return <LiveKitRoom token={token} serverUrl={process.env.NEXT_PUBLIC_LIVEKIT_URL} connect={true} video={true} audio={true} onDisconnected={()=>setToken("")}><VideoConference/></LiveKitRoom>;
}