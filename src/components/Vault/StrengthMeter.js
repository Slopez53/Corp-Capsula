import React from 'react';
import * as styles from './Vault.module.css';
import { estimateStrength } from '../../helpers/crypto';

const StrengthMeter = ({ password }) => {
  const { bits, label, score } = estimateStrength(password);
  const fill = [
    styles.meterFill1,
    styles.meterFill1,
    styles.meterFill2,
    styles.meterFill3,
    styles.meterFill4,
  ][score];

  return (
    <div>
      <div className={styles.meter}>
        {[1, 2, 3, 4].map((i) => (
          <div
            key={i}
            className={`${styles.meterBar} ${i <= score ? fill : ''}`}
          />
        ))}
      </div>
      <span className={styles.meterLabel}>
        {label} · {bits} bits de entropía
      </span>
    </div>
  );
};

export default StrengthMeter;
