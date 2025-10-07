export default function Home() {
  return (
    <div style={{ padding: '2rem', fontFamily: 'system-ui, sans-serif' }}>
      <h1>Next.js DevOps Assessment</h1>
      <p>Containerized Next.js application deployed with Docker and Kubernetes</p>
      <div style={{ marginTop: '2rem', padding: '1rem', backgroundColor: '#f5f5f5', borderRadius: '8px' }}>
        <h2>Application Status: <span style={{ color: 'green' }}>✅ Running</span></h2>
        <p>This application is successfully containerized and ready for deployment.</p>
        <ul>
          <li>✅ Next.js Application</li>
          <li>✅ Docker Containerization</li>
          <li>✅ Kubernetes Manifests</li>
          <li>✅ GitHub Actions CI/CD</li>
        </ul>
      </div>
    </div>
  )
}
