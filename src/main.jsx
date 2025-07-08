import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import './index.css'
import App from './App.jsx'
import Duck from './Duck.jsx'

let root = document.getElementById('root')
root = root ? (createRoot(root).render(
  <StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/*" element={<App />} />
        <Route path="/duck" element={<Duck />} />
      </Routes>
    </BrowserRouter>
  </StrictMode>,
)) : null

// emitted by IPFS-boot before update
const onUnload = () => {
  window.removeEventListener('unload', onUnload)
  root && root.unmount()
}
window.addEventListener('unload', onUnload)
