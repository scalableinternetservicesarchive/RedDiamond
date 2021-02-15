import React , {useState} from "react"
import PropTypes from "prop-types"

function ProfilePage(props) {
  const [username, setUsername] = useState("");
  return (
    <>
      <div className="input-tag">
          <span>Username: </span>
          <input value={username} onChange={e => setUsername(e.target.value)}/>
      </div>

      <a href={`/user/${username}`}>
        submit
      </a>

    </>
  );
}

export default ProfilePage